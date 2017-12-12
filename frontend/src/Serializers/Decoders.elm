module Serializers.Decoders exposing (..)

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
    map2 Country
        (field "code" string)
        (field "name" string)



--https://stackoverflow.com/questions/42703764/decode-a-json-tuple-to-elm-tuple/42704577#42704577
arrayAsTuple2 : Decoder a -> Decoder b -> Decoder (a, b)
arrayAsTuple2 a b =
    index 0 a
        |> andThen (\aVal -> index 1 b
            |> andThen (\bVal -> Json.Decode.succeed (aVal, bVal)))

searchResponseDecoder: Decoder SearchResponse
searchResponseDecoder =
    list (arrayAsTuple2 countryDecoder (list (arrayAsTuple2 airportDecoder (list runWayDecoder))))

countryReportDecoder: Decoder CountryReport
countryReportDecoder =
    map3 CountryReport
        (field "country" countryDecoder)
        (field "airportCount" int)
        (field "runWayTypes" (list string))

reportDecoder: Decoder Report
reportDecoder =
    map2 Report
        (field "highest" (list (countryReportDecoder)))
        (field "lowest" (list countryReportDecoder))


