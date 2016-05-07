module Form.View (root) where

import Html exposing (div, h1, h2, select, form, input, label, button, img, a, text, span, br, option, table, tr, th, thead, tbody, td, p)
import Html.Attributes exposing (class, id, value, type', placeholder, src, height, width, href)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Html.CssHelpers
import Utils.ErrorView exposing (error)
import App.Types exposing (..)
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
        [ div
            [ class [ SidebarOverlay ] ]
            []
        ]
    ]


formSection address model =
  let
    content =
      case model.status of
        Success ->
          (thanks address model)

        _ ->
          (cleanForm address model)
  in
    div
      [ class [ Container ] ]
      content


cleanForm address model =
  [ h1 [ class [ Title ] ] [ text "Never Miss a Windy Day Again." ]
  , p [ class [ Subtitle ] ] [ text "Select the minimum wind speed and the wind directions you need to sail at your spot." ]
  , p [ class [ Subtitle ] ] [ text "Leave your email and get notified whenever the weather conditions match your preferences." ]
  , div
      [ id "signup-form" ]
      [ div
          [ class [ Group ] ]
          [ label [] [ text "Email" ]
          , input
              [ id "username-field"
              , type' "text"
              , placeholder "your-email@gmail.com"
              , on "input" targetValue (Signal.message address << SetEmail)
              , value model.email
              ]
              []
          , error model.errors.email
          ]
      , div
          [ class [ Group ] ]
          [ label [] [ text "Select Country" ]
          , select
              [ on "change" targetValue (\str -> Signal.message address (SelectCountry str)) ]
              (option [] [ text "Select Country" ]
                :: (List.map countryOption model.countries)
              )
          , error model.errors.selectedCountry
          ]
      , selectRegion address model.regions
      , div
          [ class [ Group ] ]
          [ label [] [ text "Select Spot" ]
          , select
              [ on "change" targetValue (\str -> Signal.message address (SelectSpot str)) ]
              (option [] [ text "Select Spot" ]
                :: (List.map spotOption model.spots)
              )
          , error model.errors.selectedSpot
          ]
      , div
          [ class [ Group ] ]
          [ label [] [ text "Minimum Wind Speed (in knots)" ]
          , input
              [ type' "number"
              , value model.windSpeed
              , on "input" targetValue (Signal.message address << SetWindSpeed)
              ]
              []
          , error model.errors.windSpeed
          ]
      , WindDirection.View.root (Signal.forwardTo address WindDirection) model.windDirections model.errors.windDirections
      , AvailableDays.View.root (Signal.forwardTo address AvailableDays) model.availableDays model.errors.availableDays
      , br [] []
      , button
          [ onClick address SubmitAlert
          , class [ SubmitButton ]
          ]
          [ text "Submit" ]
      , p
          [ class [ Hint ] ]
          [ text "* Hint: If you want to receive alerts from another spot just sign up again with the same email and select it. You will receive alerts for both spots :)" ]
      ]
  ]


selectRegion address regions =
  if List.isEmpty regions then
    span [] []
  else
    div
      [ class [ Group ] ]
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


thanks address model =
  [ h2 [ class [ ThanksTitle ] ] [ text "Thanks! Your alert has been succesfully created." ]
  , div
      [ class [ Share ] ]
      [ h1
          [ class [ ShareTitle ] ]
          [ text "Share it with your friends*."
          , br [] []
          , text "They'll love it."
          ]
      , p [ class [ ShareHint ] ] [ text " * Not sharing with your friends in the next minute could result in 2 months without wind." ]
      , div
          []
          [ a
              [ class [ ShareIcon, Facebook ] ]
              [ img
                  [ height 84
                  , src "img/facebook.png"
                  ]
                  []
              ]
          , a
              [ class [ ShareIcon, Facebook ] ]
              [ img
                  [ height 84
                  , src "img/twitter.png"
                  ]
                  []
              ]
          ]
      ]
  ]
