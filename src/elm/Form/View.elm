module Form.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Html.CssHelpers
import Form.Types exposing (..)
import WindDirection.View
import AvailableDays.View
import AvailableDays.Types


{ id, class, classList } =
  Html.CssHelpers.withNamespace "Form"


globalClass =
  .class (Html.CssHelpers.withNamespace "")


root address model =
  div
    [ class [ Container ] ]
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
        , availableDaysView address model
        ]
    , br [] []
    , br [] []
    , text (toString model)
    ]


availableDaysView : Signal.Address Action -> Model -> Html.Html
availableDaysView address model =
  let
    context =
      { actions = 
        (Signal.forwardTo address AvailableDays)
      , setWindSpeed = 
        (Signal.forwardTo address SetWindSpeed )  
      }
  in
    AvailableDays.View.root context model.availableDays
