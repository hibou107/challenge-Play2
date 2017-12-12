
module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, type_)
import Html.Events exposing (onClick, onInput)
import Models exposing (Airport, Country, CountryReport, Model, Report, Runway, View(..))
import Msgs exposing (Msg(ChangeView, DoReport, DoSearch, OnUpdateQuery))


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


queryResultView: Model -> Html Msg
queryResultView model =
    let

        renderRunways : Runway -> Html Msg
        renderRunways runway =
            li [] [text ((toString runway.id) ++ runway.surface)]

        renderAirport : (Airport, List Runway) -> Html Msg
        renderAirport (airport, runways) =
            div []
                [
                  h4 [] [text airport.name]
                , ul [] (runways |> List.map renderRunways)
                ]


        renderCountry : (Country, List (Airport, List Runway)) -> Html Msg
        renderCountry (country, airports) =
            h3 []
               ((text (country.name ++ " (" ++ country.code ++ ")")) :: (airports |> List.map renderAirport))

    in

        case model.queryResponse of
            Nothing -> div [] []
            Just [] -> div [] [ text "No Results"]
            Just values ->
                div []
                    (
                     values |> List.map renderCountry
                    )


queryView: Model -> Html Msg
queryView model =
    let
        showResult: (List (Country, List (Airport, List Runway))) -> Html Msg
        showResult result =
            div [] []

    in
        div [class "input-group"]
            [
                button [type_ "button", class "btn btn-primary", onClick DoSearch]
                                            [text "Search"]
            ,   input [type_ "text", class "form-control", onInput OnUpdateQuery] []
            , queryResultView model
            ]

warningView : Model -> Html Msg
warningView model =
    case model.error of
        Just message ->
            div [class "alert alert-danger", attribute "role" "alert"]
                [text message]
        Nothing -> div [] []


reportResultView : Report -> Html Msg
reportResultView report =
    let
        renderCountryReport : CountryReport -> List (Html Msg)
        renderCountryReport countryReport =
            [ h3 [] [text countryReport.country.name ]
            , ul []
                [ li [] [text ("Airport count: " ++ (toString countryReport.airportCount))]
                , li [] [text ("Runway types: " ++ (String.join "," countryReport.runWayTypes))]
                ]
            ]
    in
        div []
            ([ [h2 [] [text "Highest"]]
            , report.highest |> List.map renderCountryReport |> List.concat
            , [h2 [] [text "Lowest"]]
            , report.lowest |> List.map renderCountryReport |> List.concat
            ] |> List.concat)

reportPageView : Model -> Html Msg
reportPageView model =
    case model.reportResponse of
        Just report -> reportResultView report
        Nothing ->
            div []
                [button [type_ "button", class "btn btn-primary", onClick DoReport]
                                                             [text "Generate report"]]


view : Model -> Html Msg
view model =
    div []
        [
            navView model,
            warningView model,
            case model.view of
                QueryView -> queryView model
                ReportView -> reportPageView model
        ]
