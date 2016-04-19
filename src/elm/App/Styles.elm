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
    , (#) Main 
        [ height (pct 100)
        , overflow scroll
        ]
    , Css.a
        [ color (hex "428bca")
        , textDecoration none
        ]
    ]
