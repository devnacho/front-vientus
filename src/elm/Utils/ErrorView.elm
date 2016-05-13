module Utils.ErrorView exposing (error)

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td, p)
import Form.Types exposing (..)
import Html.CssHelpers
import Translation.Utils exposing (..)

{ id, class, classList } =
  Html.CssHelpers.withNamespace "Form"


globalClass =
  .class (Html.CssHelpers.withNamespace "")


error : TranslationId -> Language -> Html.Html
error errorMessage language =
  span
    [ class [ Error ] ]
    [ text <| i18n language errorMessage ]



