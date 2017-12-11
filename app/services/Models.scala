package services

case class Airport(id: Int, name: String, idCountry: String)

case class Runway(id: Int, airPortId: Int, surface: String)

case class Country(code: String, name: String)

case class CountryReport(country: Country, airportCount: Int, runWayTypes: Set[String])

case class Report(highest: List[CountryReport], lowest: List[CountryReport])