module App.View exposing (root)

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td)
import Html.Attributes exposing (class, id, value, type', placeholder, href)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Html.CssHelpers
import App.Types exposing (..)
import Form.View
import Html.App exposing (map)


{ id, class, classList } =
  Html.CssHelpers.withNamespace "Vientus"


globalClass =
  .class (Html.CssHelpers.withNamespace "")


root model =
  div
    []
    [ map Form (Form.View.root model.form)
    ]
