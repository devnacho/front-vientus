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
import Translation.Utils exposing (..)


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
    , languageChooser address model
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
  [ img
      [ src "img/vientus_logo.png"
      , class [ Logo ]
      ]
      []
  , h1 [ class [ Title ] ] [ text <| i18n model.language TitleText ]
  , p [ class [ Subtitle ] ] [ text <| i18n model.language SubtitleText1 ]
  , p [ class [ Subtitle ] ] [ text <| i18n model.language SubtitleText2 ]
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
          [ label [] [ text <| i18n model.language SelectCountryText ]
          , select
              [ on "change" targetValue (\str -> Signal.message address (SelectCountry str)) ]
              (option [] [ text <| i18n model.language SelectCountryText ]
                :: (List.map countryOption model.countries)
              )
          , error model.errors.selectedCountry
          ]
      , selectRegion address model.regions model.language
      , div
          [ class [ Group ] ]
          [ label [] [ text <| i18n model.language SelectSpotText ]
          , select
              [ on "change" targetValue (\str -> Signal.message address (SelectSpot str)) ]
              (option [] [ text <| i18n model.language SelectSpotText ]
                :: (List.map spotOption model.spots)
              )
          , error model.errors.selectedSpot
          ]
      , div
          [ class [ Group ] ]
          [ label [] [ text <| i18n model.language MinSpeedText ]
          , input
              [ type' "number"
              , value model.windSpeed
              , on "input" targetValue (Signal.message address << SetWindSpeed)
              ]
              []
          , error model.errors.windSpeed
          ]
      , WindDirection.View.root (Signal.forwardTo address WindDirection) model.windDirections model.errors.windDirections model.language
      , AvailableDays.View.root (Signal.forwardTo address AvailableDays) model.availableDays model.errors.availableDays model.language
      , br [] []
      , button
          [ onClick address SubmitAlert
          , class [ SubmitButton ]
          ]
          [ text <| i18n model.language SubmitText ]
      , p
          [ class [ Hint ] ]
          [ text <| i18n model.language HintText ]
      ]
  ]


selectRegion address regions language =
  if List.isEmpty regions then
    span [] []
  else
    div
      [ class [ Group ] ]
      [ label [] [ text <| i18n language SelectRegionText ]
      , select
          [ on "change" targetValue (\str -> Signal.message address (SelectRegion str)) ]
          (option [] [ text <| i18n language SelectRegionText ]
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
  [ h2 [ class [ ThanksTitle ] ] [ text <| i18n model.language ThanksTitleText ]
  , div
      [ class [ Share ] ]
      [ h1
          [ class [ ShareTitle ] ]
          [ text <| i18n model.language ShareTitleText1
          , br [] []
          , text <| i18n model.language ShareTitleText2
          ]
      , p [ class [ ShareHint ] ] [ text <| i18n model.language ShareHintText ]
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


languageChooser address model =
  let
    englishClass =
      if model.language == English then
        [ LangIcon, LangActive ]
      else
        [ LangIcon ]

    spanishClass =
      if model.language == Spanish then
        [ LangIcon, LangActive ]
      else
        [ LangIcon ]
  in
    div
      [ class [ Languages ] ]
      [ a
          [ onClick address (ChangeLanguage English) ]
          [ img
              [ src "img/english.png"
              , class englishClass
              ]
              []
          ]
      , a
          [ onClick address (ChangeLanguage Spanish) ]
          [ img
              [ src "img/spanish.png"
              , class spanishClass
              ]
              []
          ]
      ]
