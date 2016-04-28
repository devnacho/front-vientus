module App.Styles (css, globalCss) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import Html.CssHelpers
import App.Types exposing (..)


css =
  (stylesheet << namespace "Vientus")
    []


globalCss =
  stylesheet 
    [ Css.html
        [ height (pct 100)
        , overflow hidden
        ]
    , Css.body
        [ fontFamilies [ "Helvetica", "Arial", "sans-serif" ]
        , margin (px 0)
        , height (pct 100)
        , overflow hidden
        ]
    , Css.label
        [ display block
        , marginBottom (em 0.375)
        , fontWeight bold
        , fontSize (em 1)
        ]
    , Css.input
        [ width (pct 100)
        , display block
        , fontSize (em 1)
        , borderRadius (px 3)
        , border3 (px 1) solid (hex "DDD" )
        , padding2 (em 0.5) (em 0.5)
        , backgroundColor (hex "FFF")
        , boxSizing borderBox
        ]
    , Css.select
        [ width (pct 100)
        , display block
        , marginBottom (em 1.5)
        , fontSize (em 0.9)
        , border3 (px 1) solid (hex "CCC" )
        , borderRadius (px 4)
        , height (px 34)
        , padding2 (px 6) (px 12)
        , lineHeight (em 1.4)
        , verticalAlign middle
        , backgroundColor (hex "FFF")
        ]
    , (#) Main 
        [ height (pct 100)
        , overflow scroll
        ]
    , Css.a
        [ color (hex "428bca")
        , textDecoration none
        ]
    ]
