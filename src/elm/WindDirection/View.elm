module WindDirection.View exposing (root)

import Html exposing (div, h1, select, form, input, label, button, a, text, span, br, option, table, tr, th, thead, tbody, td, i)
import Html.Attributes exposing (class, id, value, type', placeholder)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import Utils.ErrorView exposing (error)
import WindDirection.Types exposing (..)
import Html.CssHelpers
import Translation.Utils exposing (..)


namespace =
  "WindDir"


{ id, class, classList } =
  Html.CssHelpers.withNamespace namespace


globalClass =
  .class (Html.CssHelpers.withNamespace "")


root model errors language =
  div
    []
    [ label [] [ text <| i18n language SelectWindDirText ]
    , div
        [ class [ Chooser ] ]
        (List.map (\wd -> windButton wd model) allWindDirections)
    , error errors language
    ]


windButton windDirection model =
  div
    [ classList
        [ (Direction, True)
        , (Selected, List.member windDirection model )
        ]
    , onClick (ToggleWindDirection windDirection)
    ]
    [ div
        [ class [ Text ] ]
        [ text (toString windDirection) ]
    , i
        [ Html.Attributes.class (namespace ++ "Icon icon ion-ios-arrow-thin-down")
        ]
        []
    ]
