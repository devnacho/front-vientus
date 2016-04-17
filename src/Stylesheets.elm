module Stylesheets (..) where

import Css.File exposing (..)
import Components.Hello
import Components.Goodbye


port files : CssFileStructure
port files =
  toFileStructure
    [ ( "hello.css", compile Components.Hello.css )
    , ( "goodbye.css", compile Components.Goodbye.css ) ]
