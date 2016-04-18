module Stylesheets (..) where

import Css.File exposing (..)
import App.Styles exposing (css)

port files : CssFileStructure
port files =
  toFileStructure
    [ ( "app.css", compile App.Styles.css ) ]

