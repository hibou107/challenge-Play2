package services
import play.api.libs.json._

object JsonSerializers {
  implicit val airportFormat: Format[Airport] = Json.format[Airport]
  implicit val runWayFormat: Format[Runway] = Json.format[Runway]
  implicit val countryFormat: Format[Country] = Json.format[Country]
  implicit val countryReportFormat: Format[CountryReport] = Json.format[CountryReport]
  implicit val reportFormat: Format[Report] = Json.format[Report]
}
