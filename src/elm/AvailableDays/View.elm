module AvailableDays.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import AvailableDays.Types exposing (..)


root context model =
  div
    []
    [ button
        [ onClick context.actions ToggleDaysVisibility ]
        [ text "Want to choose the days you can sail? " ]
    , button
        [ onClick context.setWindSpeed "55" ]
        [ text "change wind speed from here" ]
    , selectDays context model.visible
    ]


selectDays context visible =
  if visible then
    div
      [ class "form-field" ]
      [ label [] [ text "Select Days of Week" ]
      , div
          []
          (List.map (\day -> dayButton context day) allDaysOfWeek)
      ]
  else
    span [] []


dayButton context day =
  button
    [ onClick context.actions (ToggleDay day) ]
    [ text (toString day) ]
