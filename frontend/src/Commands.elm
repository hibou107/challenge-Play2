module Commands exposing (..)

import Http exposing (Error)
import Json.Encode
import Models exposing (Report, SearchResponse)
import Msgs exposing (Msg(OnError, OnReportResult, OnSearchResult))
import Serializers.Decoders exposing (reportDecoder, searchResponseDecoder)

resolveError: (a -> Msg) -> Result Http.Error a -> Msg
resolveError f resultWithError =
    case resultWithError of
        Result.Ok value -> f value
        err -> OnError (toString err)

searchRequest: String -> Http.Request SearchResponse
searchRequest searchStr =
    Http.post
        "/search"
        (Json.Encode.string searchStr |> Http.jsonBody)
        searchResponseDecoder

searchCommand: String -> Cmd Msg
searchCommand searchStr =
    searchRequest searchStr |> Http.send (resolveError OnSearchResult)


reportRequest: Http.Request Report
reportRequest = Http.get "/report" reportDecoder

reportCommand: Cmd Msg
reportCommand =
    reportRequest |> Http.send (resolveError OnReportResult)