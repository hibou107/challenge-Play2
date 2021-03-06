package services

case class DataService(airPorts: List[Airport], runways: List[Runway], countries: List[Country]) {

  val MAX_SEARCH_RESULT = 10

  private val byCountries: Map[String, List[(Airport, List[Runway])]] = {
    val runWayByAirport = runways.groupBy(_.airPortId)
    val airPortByIds = airPorts.groupBy(_.id).mapValues(_.head).view.force
    val airportWithRunways = airPortByIds map { case (airPortId, airPort) =>
        val thisRunWays = runWayByAirport.getOrElse(airPortId, Nil)
      (airPort, thisRunWays)
    }
    airportWithRunways.toList.groupBy(_._1.idCountry).map { case (key, v) => (key.toLowerCase(), v) }
  }

  private val countriesByCode: Map[String, Country] =
    countries.groupBy(_.code).mapValues(_.head).map(x => x.copy(_1 = x._1.toLowerCase))

  private val countriesByName: Map[String, Country] =
    countries.groupBy(_.name).mapValues(_.head).map(x => x.copy(_1 = x._1.toLowerCase))

  private def searchByCountryCode(code: String): Option[(Country, List[(Airport, List[Runway])])] = {
    byCountries.get(code).map(result => (countriesByCode(code), result))
  }

  private def searchByCountryName(name: String): List[(Country, List[(Airport, List[Runway])])] = {
    countriesByName.get(name) match {
      case Some(v) =>
        (v, byCountries(v.code.toLowerCase())) :: Nil
      case None =>
        val init = List.empty[(Country, List[(Airport, List[Runway])])]
        countriesByName.foldLeft(init) { case (currentResult, (countryName, country)) =>
          if (currentResult.length > MAX_SEARCH_RESULT)
            currentResult
          else
            if (countryName.startsWith(name)) {
              (country, byCountries(country.code.toLowerCase)) :: currentResult
            } else currentResult
        }
    }
  }

  // Input can be a partial country name or country code
  def searchCountry(input: String): List[(Country, List[(Airport, List[Runway])])] = {
    val trimed = input.trim.toLowerCase
    searchByCountryCode(trimed) match {
      case Some(result) => result :: Nil
      case None =>
        searchByCountryName(trimed)
    }
  }


  def reports(number: Int): Report = {
    val withAirportNumbers = byCountries.map { case (countryCode, results) =>
      CountryReport(countriesByCode(countryCode.toLowerCase), results.length, results.flatMap(_._2.map(_.surface)).toSet)
    }.toList
    val sorted = withAirportNumbers.sortBy(_.airportCount)
    val (lowest, highest) = DataService.split(sorted)
    val takeLowest = lowest.take(number)
    val takeHIghest = highest.reverse.take(number)
    Report(takeHIghest, takeLowest)
  }
}


object DataService {
  def split[A](input: List[A]): (List[A], List[A]) = {
    input.length match {
      case 0 => (Nil, Nil)
      case 1 => (Nil, input)
      case  _ =>
        val midIndex = input.length / 2
        input.splitAt(midIndex)
    }
  }
}
