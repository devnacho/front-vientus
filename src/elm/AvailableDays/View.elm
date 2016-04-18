module AvailableDays.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import AvailableDays.Types exposing (..)


root address model =
  div
    []
    [ button
        [ onClick address ToggleDaysVisibility ]
        [ text "Want to choose the days you can sail? " ]
    , selectDays address model
    ]


selectDays address model =
  if model.visible then
    div
      [ class "form-field" ]
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
