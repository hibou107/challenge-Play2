module Update exposing (..)

import Commands exposing (reportCommand, searchCommand)
import Models exposing (Model)
import Msgs exposing (..)


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        ChangeView view ->
            ( { model | view = view }, Cmd.none )
        DoSearch -> ( model, searchCommand model.query)
        OnSearchResult result ->
            ( { model | queryResponse = Just result }, Cmd.none )
        DoReport ->
            ( model, reportCommand )
        OnReportResult result ->
            ( { model | reportResponse = Just result }, Cmd.none )
        OnError err ->
            ( { model | error = Just err }, Cmd.none )
        OnUpdateQuery value ->
            ( { model | query = value }, Cmd.none )