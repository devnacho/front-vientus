module AvailableDays.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Html.CssHelpers
import Utils.ErrorView exposing (error)
import AvailableDays.Types exposing (..)


{ id, class, classList } =
  Html.CssHelpers.withNamespace "Days"


globalClass =
  .class (Html.CssHelpers.withNamespace "")

root address model errors =
  div
    []
    [ button
        [ onClick address ToggleDaysVisibility ]
        [ text "Want to choose the days you can sail? " ]
    , selectDays address model.visible
    , error errors
    ]


selectDays address visible =
  if visible then
    div
      []
      [ label [] [ text "Select Days of Week" ]
      , div
          []
          (List.map (\day -> dayButton address day) allDaysOfWeek)
      ]
  else
    span [] []


dayButton address day =
  button
    [ onClick address (ToggleDay day) ]
    [ text (toString day) ]
