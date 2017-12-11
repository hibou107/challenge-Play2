package services

import scala.io.Source
import scala.util.Try
import com.opencsv.CSVReader

import scala.annotation.tailrec
import scala.language.postfixOps


object CSVLoader {

  @tailrec
  private def parseLine[A](reader: CSVReader, result: List[A], f: Array[String] => A): List[A] = {
    val next = reader.readNext()
    if (next == null)
      result
    else {
        parseLine(reader, f(next) :: result, f)
    }
  }

  private def parseAll[A](fileName: String)(f: Array[String] => A): List[A] = {
    val reader = Source.fromResource(fileName).reader()
    val csvReader = new CSVReader(reader)
    csvReader.readNext() // ignore first line
    parseLine(csvReader, Nil, f)
    }



  def loadAirportFile(path: String): Try[List[Airport]] = Try {
    parseAll(path) { line =>
      val id = line(0).toInt
      val name = line(3)
      val idCountry = line(8)
      Airport(id, name, idCountry)
    }
  }

  def loadRunwayFile(path: String) = Try {
    parseAll(path) { line =>
      val id = line(0).toInt
      val airportId = line(1).toInt
      val surface = line(5)
      Runway(id, airportId, surface)
    }
  }

  def loadCountryFile(path: String) = Try {
    parseAll(path) { line =>
      val code = line(1)
      val name = line(2)
      Country(code, name)
    }
  }

  def loadData(airport: String, runway: String, country: String): Try[DataService] = {
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
