module WindDirection.View (root) where

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td, i)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Utils.ErrorView exposing (error)
import WindDirection.Types exposing (..)
import Html.CssHelpers

namespace = "WindDir"

{ id, class, classList } =
  Html.CssHelpers.withNamespace namespace


globalClass =
  .class (Html.CssHelpers.withNamespace "")

root address model errors =
  div
    []
    [ label [] [ text "Select wind directions" ]
    , div
        [ class [ Chooser ] ]
        (List.map (\wd -> windButton address wd) allWindDirections)
    , error errors
    ]

windButton address windDirection = 
  div
    [ class [ Direction ] ]
    [ div
      [ class [ Text ]  ]
      [ text (wdToStr windDirection) ]
    , i
      [ Html.Attributes.class (namespace ++ "Icon icon ion-ios-arrow-thin-up")
      ]
      []
    ]
{-
windButton address windDirection =
  button
    [ onClick address (ToggleWindDirection windDirection) ]
    [ text (toString windDirection) ]
-}
