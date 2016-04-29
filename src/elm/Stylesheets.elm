module Stylesheets (..) where

import Css.File exposing (..)
import App.Styles
import Form.Styles
import WindDirection.Styles


port files : CssFileStructure
port files =
  toFileStructure
    [ ( "global.css", compile App.Styles.globalCss )
    , ( "app.css", compile App.Styles.css )
    , ( "form.css", compile Form.Styles.css )
    , ( "wind-direction.css", compile WindDirection.Styles.css )
    ]
