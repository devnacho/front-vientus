port module Stylesheets exposing (..)

import Css.File exposing (..)
import App.Styles
import Form.Styles
import WindDirection.Styles
import AvailableDays.Styles

import Html exposing (div)
import Html.App as Html


port files : CssFileStructure -> Cmd msg

cssFiles : CssFileStructure
cssFiles =
    toFileStructure
      [ ( "global.css", compile App.Styles.globalCss )
      , ( "app.css", compile App.Styles.css )
      , ( "form.css", compile Form.Styles.css )
      , ( "wind-direction.css", compile WindDirection.Styles.css )
      , ( "available-days.css", compile AvailableDays.Styles.css )
      ]

main : Program Never
main =
    Html.program
        { init = ( (), files cssFiles )
        , view = \_ -> (div [] [])
        , update = \_ _ -> ( (), Cmd.none )
        , subscriptions = \_ -> Sub.none
        }
