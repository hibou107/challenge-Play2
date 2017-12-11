
module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, href, type_)
import Html.Events exposing (onClick)
import Models exposing (Model, View(..))
import Msgs exposing (Msg(ChangeView))



--<ul class="nav nav-tabs">
--  <li role="presentation" class="active"><a href="#">Query</a></li>
--  <li role="presentation"><a href="#">Report</a></li>
--</ul>

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

-- VIEW

--<div class="input-group">
--  <div class="input-group-btn">
--    <button type="button" class="btn btn-primary">Apple</button>
--    <!-- Button and dropdown menu -->
--  </div>
--  <input type="text" class="form-control" aria-label="...">
--</div>

queryView: Model -> Html Msg
queryView model =
    div [class "input-group"]
        [
            div [class "input-group-btn"]
                [
                    button [type_ "button", class "btn btn-primary"]
                        [text "Search"]
                ]
        ,   input [type_ "text", class "form-control"] []
        ]




view : Model -> Html Msg
view model =
    div []
        [
            navView model,
            case model.view of
                QueryView -> queryView model
                ReportView -> text "Hello"
        ]