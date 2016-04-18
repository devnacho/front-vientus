module App.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import App.Types exposing (..)
import WindDirection.View
import AvailableDays.View


root address model =
  div
    []
    [ h1 [] [ text "Never Miss a Windy Day Again." ]
    , div
        [ id "signup-form" ]
        [ div
            [ class "form-field" ]
            [ label [] [ text "Email" ]
            , input
                [ id "username-field"
                , type' "text"
                , placeholder "your-email@gmail.com"
                , on "input" targetValue (Signal.message address << SetEmail)
                , value model.email
                ]
                []
            ]
        , div
            [ class "form-field" ]
            [ label [] [ text "Select Country" ]
            , select
                []
                [ option [ id "1" ] [ text "Argentina" ]
                , option [ id "2" ] [ text "Spain" ]
                ]
            ]
        , div
            [ class "form-field" ]
            [ label [] [ text "Minimum Wind Speed (in knots)" ]
            , input
                [ type' "number"
                , value model.windSpeed
                , on "input" targetValue (Signal.message address << SetWindSpeed)
                ]
                []
            ]
        , WindDirection.View.root (Signal.forwardTo address WindDirection) model.windDirections
        , AvailableDays.View.root (Signal.forwardTo address AvailableDays) model.availableDays
        ]
    , br [] []
    , br [] []
    , text (toString model)
    ]


