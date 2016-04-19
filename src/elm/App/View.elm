module App.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td)
import Html.Attributes exposing (class, id, value, type', placeholder, href)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Html.CssHelpers
import App.Types exposing (..)
import Form.View


{ id, class, classList } =
  Html.CssHelpers.withNamespace "Vientus"


globalClass =
  .class (Html.CssHelpers.withNamespace "")


root address model =
  div
    []
    [ div
        [ class [ FormSection ] ]
        [ Form.View.root (Signal.forwardTo address Form) model.form ]
    , div
        [ class [ Sidebar ] ]
        [ text "Sidebar goes here" ]
    ]

