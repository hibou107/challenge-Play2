module Main exposing (..)

import Html exposing (Html, div, text, program)
import Models exposing (Model, View(..))
import Msgs exposing (Msg(..))
import Update exposing (update)
import Views exposing (view)

initModel : Model
initModel =
    { view = QueryView
    , queryResponse = Nothing
    , reportResponse = Nothing
    }

init : ( Model, Cmd Msg )
init =
    ( initModel, Cmd.none )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }