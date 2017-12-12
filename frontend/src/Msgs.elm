module Msgs exposing (..)

import Models exposing (Report, SearchResponse, View)


-- MESSAGES


type Msg
    = NoOp
        | ChangeView View
        | DoSearch
        | OnSearchResult SearchResponse
        | OnReportResult Report
        | OnError String
