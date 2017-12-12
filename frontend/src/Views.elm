
module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, type_)
import Html.Events exposing (onClick)
import Models exposing (Airport, Country, Model, Runway, View(..))
import Msgs exposing (Msg(ChangeView, DoSearch))


navView: Model -> Html Msg
navView model =
    let
        render: String -> Bool -> Msg -> Html Msg
        render message isActive onClickMsg =
            li [attribute "role" "presentation", if isActive then class "active" else class ""] [a [onClick onClickMsg] [text message]]
    in
        ul
            [class "nav nav-tabs"]
            [
                render "Query" (model.view == QueryView) (ChangeView QueryView),
                render "Report" (model.view == ReportView) (ChangeView ReportView)
            ]


queryView: Model -> Html Msg
queryView model =
    let
        showResult: (List (Country, List (Airport, List Runway))) -> Html Msg
        showResult result =
            div [] []

        queryResultView: Model -> Html Msg
        queryResultView model =
            case model.queryResponse of
                Nothing -> div [] [text "No result yet"]
                Just result ->
                    showResult result
    in
        div [class "input-group"]
            [
                div [class "input-group-btn"]
                    [
                        button [type_ "button", class "btn btn-primary", onClick DoSearch]
                            [text "Search"]
                    ]
            ,   input [type_ "text", class "form-control"] []
            ]

--    <div class="alert alert-danger" role="alert">...</div>

warningView : Model -> Html Msg
warningView model =
    case model.error of
        Just message ->
            div [class "alert alert-danger", attribute "role" "alert"]
                [text message]
        Nothing -> div [] []


view : Model -> Html Msg
view model =
    div []
        [
            navView model,
            warningView model,
            case model.view of
                QueryView -> queryView model
                ReportView -> text "Hello"
        ]