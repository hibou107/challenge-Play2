module Models exposing (..)

-- MODEL

--case class Airport(id: Int, name: String, idCountry: String)
--
--case class Runway(id: Int, airPortId: Int, surface: String)
--
--case class Country(code: String, name: String)
--
--case class CountryReport(country: Country, airportCount: Int, runWayTypes: Set[String])
--
--case class Report(highest: List[CountryReport], lowest: List[CountryReport])

type View = QueryView | ReportView

type alias Airport =
    { id : Int
    , name : String
    , idCountry: String
    }

type alias Runway =
    { id : Int
    , airPortId : Int
    , surface : String
    }

type alias Country =
    { code : String
    , name : String
    }

type alias CountryReport =
    { country : Country
    , airportCount : Int
    , runWayTypes: List String
    }


type alias Report =
    { highest : List CountryReport
    , lowest: List CountryReport
    }



type alias SearchResponse = List (Country, List (Airport, List Runway))

type alias Model =
     { view : View
      , error : Maybe String
      , query: String
      , queryResponse : Maybe SearchResponse
      , reportResponse : Maybe Report
      }