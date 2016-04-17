module Components.Goodbye where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers
import String
import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)


cssNamespace = "goodbye"

{ class, classList, id } = Html.CssHelpers.withNamespace cssNamespace


type CssClasses =
  Content 

css =
  (stylesheet << namespace cssNamespace)
    [ (.) Content
        [ Css.width (px 960)
        , margin2 zero auto
        , backgroundColor (hex "00FFFF")
        ]
    ]

