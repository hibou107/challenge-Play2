module Main exposing (..)

import Html exposing (Html, div, text, program)
import Models exposing (Model)
import Msgs exposing (Msg(..))
import Views exposing (view)


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

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