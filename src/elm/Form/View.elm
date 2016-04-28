module Form.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td, p)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Html.CssHelpers
import Form.Types exposing (..)
import WindDirection.View
import AvailableDays.View


{ id, class, classList } =
  Html.CssHelpers.withNamespace "Form"


globalClass =
  .class (Html.CssHelpers.withNamespace "")


root address model =
  div
    []
    [ div
        [ class [ FormSection ] ]
        [ formSection address model ]
    , div
        [ class [ SidebarSection ] ]
        [ text "Sidebar Component goes here" ]
    ]


formSection address model =
  div
    [ class [ Container ] ]
    [ h1 [] [ text "Never Miss a Windy Day Again." ]
    , p [] [ text "Select the minimum wind speed and the wind directions you need to sail at your spot." ]
    , p [] [ text "Leave your email and get notified whenever the weather conditions match your preferences." ]
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
                [ on "change" targetValue (\str -> Signal.message address (SelectCountry str)) ]
                (option [] [ text "Select Country" ]
                  :: (List.map countryOption model.countries)
                )
            ]
        , selectRegion address model.regions
        , div
            []
            [ label [] [ text "Select Spot" ]
            , select
                [ on "change" targetValue (\str -> Signal.message address (SelectSpot str)) ]
                (option [] [ text "Select Spot" ]
                  :: (List.map spotOption model.spots)
                )
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
        , br [] []
        , br [] []
        , button [ onClick address SubmitAlert ] [ text "Submit" ]
        ]
    , br [] []
    , br [] []
    , text (toString model.errors)
    , br [] []
    , br [] []
    , text (toString model.selectedSpot)
    ]

selectRegion address regions =
  if List.isEmpty regions then
    span [] []
  else
    div
      []
      [ label [] [ text "Select Region" ]
      , select
          [ on "change" targetValue (\str -> Signal.message address (SelectRegion str)) ]
          (option [] [ text "Select Region" ]
            :: (List.map regionOption regions)
          )
      ]



countryOption country =
  option [ value country.id ] [ text country.name ]


regionOption region =
  option [ value region.id ] [ text region.name ]


spotOption spot =
  option [ value spot.id ] [ text spot.name ]
