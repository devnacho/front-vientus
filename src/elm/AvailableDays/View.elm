module AvailableDays.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td, i)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Html.CssHelpers
import Utils.ErrorView exposing (error)
import AvailableDays.Types exposing (..)
import Translation.Utils exposing (..)

namespace =
  "Days"


{ id, class, classList } =
  Html.CssHelpers.withNamespace namespace


globalClass =
  .class (Html.CssHelpers.withNamespace "")


root address model errors language =
  div
    []
    [ a
        [ onClick address ToggleDaysVisibility
        , class [ Toggle ]
        ]
        [ i [ Html.Attributes.class (namespace ++ "DateIcon icon ion-calendar") ] []
        , text <| i18n language ToggleDaysText
        ]
    , selectDays address model language
    , error errors language
    ]


selectDays address model language =
  if model.visible then
    div
      []
      [ label [] [ text <| i18n language SelectDaysText ]
      , div
          []
          (List.map (\day -> dayButton address day model.days) allDaysOfWeek)
      ]
  else
    span [] []


dayButton address day selectedDays =
  let
    buttonClass =
      if List.member day selectedDays then
        [ Button, Selected ]
      else
        [ Button ]

    icon =
      if List.member day selectedDays then
        i [ Html.Attributes.class (namespace ++ "Icon icon ion-checkmark") ] []
      else
        i [ Html.Attributes.class (namespace ++ "Icon icon ion-close") ] []
  in
    div
      [ class buttonClass
      , onClick address (ToggleDay day)
      ]
      [ text (toString day)
      , icon
      ]
