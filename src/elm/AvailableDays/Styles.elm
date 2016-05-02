module AvailableDays.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import AvailableDays.Types exposing (..)

css =
  (stylesheet << namespace "Days")
    [ (.) Button
        [ display inlineBlock
        , width (px 50)
        , textAlign center
        , margin2 (px 10) (px 5)
        , padding2 (px 6) (px 0)
        , border3 (px 2) solid (hex "CCC")
        , color (hex "CCC")
        , fontSize (px 11)
        , textTransform uppercase
        , hover
            [ property "cursor" "pointer"
            ]
        ]
    , (.) Selected
        [ color (hex "20AA73") 
        , border3 (px 2) solid (hex "20AA73") 
        , hover
          [ color (hex "20AA73")
          , border3 (px 2) solid (hex "20AA73") 
          ]
        ]
    , (.) Icon
        [ marginLeft (px 8) 
        ]
    ]
