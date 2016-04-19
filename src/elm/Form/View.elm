module Form.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Html.CssHelpers
import Form.Types exposing (..)
import WindDirection.View
import AvailableDays.View


{ id, class, classList } =
  Html.CssHelpers.withNamespace "form"


globalClass =
  .class (Html.CssHelpers.withNamespace "")


root address model =
  div
    []
    [ h1 [] [ text "Never Miss a Windy Day Again." ]
    , div
        [ id "signup-form" ]
        [ div
            []
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
            []
            [ label [] [ text "Select Country" ]
            , select
                []
                [ option [ id "1" ] [ text "Argentina" ]
                , option [ id "2" ] [ text "Spain" ]
                ]
            ]
        , div
            []
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
