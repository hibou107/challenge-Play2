package services
import scala.io.Source
import scala.util.Try



object CSVLoader {
  def loadAirportFile(path: String): Try[List[Airport]] = Try {
    val iterLines  = Source.fromResource(path).getLines
    iterLines.drop(1).map { text =>
      val strVector = text.split(",").map(_.trim.replace("\"", "")).toVector
      val id = strVector(0).toInt
      val name = strVector(3)
      val idCountry = strVector(8)
      if (idCountry.toLowerCase == "oc")
        println(s"found $id $name")
      Airport(id, name, idCountry)

    } toList
  }

  def loadRunwayFile(path: String) = Try {
    val iterLines  = Source.fromResource(path).getLines
    iterLines.drop(1).map { text =>
      val strVector = text.split(",").map(_.trim.replace("\"", "")).toVector
      val id = strVector(0).toInt
      val airportId = strVector(1).toInt
      val surface = strVector(5)
      Runway(id, airportId, surface)
    } toList
  }

  def loadCountryFile(path: String) = Try {
    val iterLines  = Source.fromResource(path).getLines
    iterLines.drop(1).map { text =>
      val strVector = text.split(",").map(_.trim.replace("\"", "")).toVector
      val code = strVector(1)
      val name = strVector(2)

      Country(code, name)
    } toList
  }

  def loadData(airport: String, runway: String, country: String) = {
    for {
      airports <- loadAirportFile(airport)
      runways <- loadRunwayFile(runway)
      countries <- loadCountryFile(country)
    } yield {

      DataService(airports, runways, countries)
    }
  }

  def main(args: Array[String]): Unit = {
    val data = loadData("airports.csv", "runways.csv", "countries.csv").get
    println(data.reports(10))

  }


}
