module Serializers.Encoders exposing (..)
import Json.Decode exposing (..)
import Models exposing (..)

airportDecoder: Decoder Airport
airportDecoder =
    map3 Airport
        (field "id" int)
        (field "name" string)
        (field "idCountry" string)

runWayDecoder: Decoder Runway
runWayDecoder =
    map3 Runway
        (field "id" int)
        (field "airPortId" int)
        (field "surface" string)


countryDecoder: Decoder Country
countryDecoder =
    map2 Runway
        (field "code" string)
        (field "name" string)

countryReportDecoder: Decoder CountryReport
countryReportDecoder =
    map3 CountryReport
        (field "country" countryDecoder)
        (field "airportCount" int)
        (field "runWayTypes" (list string))
