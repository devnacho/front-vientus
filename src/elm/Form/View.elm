module Form.View exposing (root)

import Html exposing (div, h1, h2, select, form, input, label, button, img, a, text, span, br, option, table, tr, th, thead, tbody, td, p)
import Html.Attributes exposing (class, classList, id, value, type', placeholder, src, height, width, href, style)
import Html.Events exposing (onClick, targetValue, on, targetChecked, onInput)
import Html.App exposing (map)
import Html.CssHelpers
import Utils.ErrorView exposing (error)
import App.Types exposing (..)
import Form.Types exposing (..)
import WindDirection.View
import AvailableDays.View
import Translation.Utils exposing (..)
import Json.Decode as Json
import Random


{ id, class, classList } =
  Html.CssHelpers.withNamespace "Form"


globalClass =
  .class (Html.CssHelpers.withNamespace "")


root randomSeed model =
  div
    []
    [ div
        [ class [ FormSection ] ]
        [ formSection model ]
    , div
        [ class [ SidebarSection ]
        , style <| backgroundStyle randomSeed
        ]
        [ div
            [ class [ SidebarOverlay ] ]
            []
        ]
    , languageChooser model
    ]


formSection model =
  let
    content =
      case model.status of
        Success ->
          (thanks model)

        _ ->
          (cleanForm model)
  in
    div
      [ class [ Container ] ]
      content


cleanForm model =
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
              , placeholder <| i18n model.language EmailPlaceholderText
              , onInput SetEmail
              , value model.email
              ]
              []
          , error model.errors.email model.language
          ]
      , div
          [ class [ Group ] ]
          [ label [] [ text <| i18n model.language SelectCountryText ]
          , select
              [ on "change" (Json.map SelectCountry targetValue )]
              (option [] [ text <| i18n model.language SelectCountryText ]
                :: (List.map countryOption model.countries)
              )
          , error model.errors.selectedCountry model.language
          ]
      , selectRegion model.regions model.language
      , div
          [ class [ Group ] ]
          [ label [] [ text <| i18n model.language SelectSpotText ]
          , select
              [ on "change" (Json.map SelectSpot targetValue )]
              (option [] [ text <| i18n model.language SelectSpotText ]
                :: (List.map spotOption model.spots)
              )
          , ( error model.errors.selectedSpot model.language )
          ]
      , div
          [ class [ Group ] ]
          [ label [] [ text <| i18n model.language MinSpeedText ]
          , input
              [ type' "number"
              , value model.windSpeed
              , onInput SetWindSpeed
              ]
              []
          , ( error model.errors.windSpeed model.language )
          ]
      , WindDirection.View.root model.windDirections model.errors.windDirections model.language 
      , map AvailableDays (AvailableDays.View.root model.availableDays model.errors.availableDays model.language)
      , br [] []
      , button
          [ onClick SubmitAlert
          , class [ SubmitButton ]
          ]
          [ text <| i18n model.language SubmitText ]
      , p
          [ class [ Hint ] ]
          [ text <| i18n model.language HintText ]
      ]
  ]


selectRegion regions language =
  if List.isEmpty regions then
    span [] []
  else
    div
      [ class [ Group ] ]
      [ label [] [ text <| i18n language SelectRegionText ]
      , select
          [ on "change" (Json.map SelectRegion targetValue )]
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


thanks model =
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
              [ class [ ShareIcon, Facebook ]
              , onClick (ShareVientus "Facebook")
              ]
              [ img
                  [ height 84
                  , src "img/facebook.png"
                  ]
                  []
              ]
          , a
              [ class [ ShareIcon, Twitter ]
              , onClick (ShareVientus "Twitter")
              ]
              [ img
                  [ height 84
                  , src "img/twitter.png"
                  ]
                  []
              ]
          ]
      ]
  ]


languageChooser model =
  div
    [ class [ Languages ] ]
    [ a
        [ onClick (ChangeLanguage English) ]
        [ img
            [ src "img/english.png"
            , classList
                [ (LangIcon, True)
                , (LangActive, model.language == English)
                ]
            ]
            []
        ]
    , a
        [ onClick (ChangeLanguage Spanish) ]
        [ img
            [ src "img/spanish.png"
            , classList
                [ (LangIcon, True)
                , (LangActive, model.language == Spanish)
                ]
            ]
            []
        ]
    ]


backgroundStyle : Int -> List (String, String)
backgroundStyle randomSeed =
  let
    number = toString <| fst <| Random.step (Random.int 1 4) (Random.initialSeed randomSeed)
  in
    [ ("background", "url(img/bg" ++ number ++ ".jpg) center center")
    , ("background-size", "cover")
    ]
