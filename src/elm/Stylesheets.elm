module Stylesheets (..) where

import Css.File exposing (..)
import App.Styles exposing (css)


port files : CssFileStructure
port files =
  toFileStructure
    [ ( "global.css", compile App.Styles.globalCss )
    , ( "app.css", compile App.Styles.css )
    ]
