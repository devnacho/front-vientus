module Utils.ErrorView (error) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td, p)
import Form.Types exposing (..)
import Html.CssHelpers

{ id, class, classList } =
  Html.CssHelpers.withNamespace "Form"


globalClass =
  .class (Html.CssHelpers.withNamespace "")


error : String -> Html.Html
error errorMessage =
  span
    [ class [ Error ] ]
    [ text errorMessage ]



