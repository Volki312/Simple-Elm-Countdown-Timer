module Main exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser
import Html exposing (..)
import Time



-- MAIN


main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { time : Int }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { time = 1609455600000 }, Cmd.none )



-- UPDATE


type Msg
    = Tick Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick time ->
            let
                millis =
                    Time.posixToMillis time
            in
            ( { model | time = millis }
            , Cmd.none
            )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick



-- VIEW


view : Model -> Html Msg
view model =
    let
        timeDiff =
        -- 1609455600001 to posix time is 1/1/2021 00:00:00
            1609455600001 - model.time

        day =
            String.fromInt (round (toFloat timeDiff / toFloat (1000 * 60 * 60 * 24)))

        hour =
            String.fromInt (round (toFloat (remainderBy (1000 * 60 * 60 * 24) timeDiff) / toFloat (1000 * 60 * 60)))

        minute =
            String.fromInt (round (toFloat (remainderBy (1000 * 60 * 60) timeDiff) / toFloat (1000 * 60)))

        second =
            String.fromInt (round (toFloat (remainderBy (1000 * 60) timeDiff) / toFloat 1000))
    in
    div []
        [ if timeDiff < 0 then
            h1 [] [ text "EXPIRED" ]

          else
            h1 [] [ text (day ++ " days, " ++ hour ++ ":" ++ minute ++ ":" ++ second ++ " until 1/1/2021 00:00:00") ]
        ]
