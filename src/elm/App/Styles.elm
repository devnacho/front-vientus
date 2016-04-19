module App.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import Html.CssHelpers

import App.Types exposing (..)


css =
  (stylesheet << namespace "vientus")
    [ Css.body
        [  fontFamilies [ "Helvetica", "Arial", "sans-serif" ]
        ]
    , Css.a
        [ color ( hex "428bca" )
        , textDecoration none
        ]
    , (.) FormField
        [ marginBottom ( px 30 )
        ]
    ]
