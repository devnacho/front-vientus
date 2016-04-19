module Stylesheets (..) where

import Css.File exposing (..)
import App.Styles
import Form.Styles


port files : CssFileStructure
port files =
  toFileStructure
    [ ( "global.css", compile App.Styles.globalCss )
    , ( "app.css", compile App.Styles.css )
    , ( "form.css", compile Form.Styles.css )
    ]
