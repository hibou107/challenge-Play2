
module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (attribute, class, href)
import Models exposing (Model)
import Msgs exposing (Msg)



--<ul class="nav nav-tabs">
--  <li role="presentation" class="active"><a href="#">Query</a></li>
--  <li role="presentation"><a href="#">Report</a></li>
--</ul>

navView: Model -> Html Msg
navView model =
    ul
        [class "nav nav-tabs"]
        [
            li [attribute "role" "presentation", class "active"] [a [href "#"] [text "Query"]],
            li [attribute "role" "presentation"] [a [href "#"] [text "Query"]]
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [
            navView model,
            text model
        ]