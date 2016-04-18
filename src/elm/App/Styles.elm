module App.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import Html.CssHelpers

cssNamespace = "homepage"
{ class, classList, id } = Html.CssHelpers.withNamespace cssNamespace


type CssClasses =
  Content 

css =
  (stylesheet << namespace cssNamespace)
    [ Css.body
        [ backgroundColor (hex "FF00FF") ]
    , (.) Content
        [ Css.width (px 960)
        , margin2 zero auto
        , backgroundColor (hex "FFFF00")
        , fontSize (px 30)
        , fontWeight bold
        ]
    ]
