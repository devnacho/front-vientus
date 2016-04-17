module Components.Hello where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.CssHelpers
import String
import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)


cssNamespace = "homepage"
{ class, classList, id } = Html.CssHelpers.withNamespace cssNamespace


type CssClasses =
  Content 

-- hello component
hello model =
  div
    [ class [ Content ] ]
    [ text ( "Hello, World" ++ ( "!" |> String.repeat model ) ) ]


-- CSS
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

