module App.Types (..) where

import Form.Types
import Translation.Utils exposing (..)


type Action
  = NoOp
  | Form Form.Types.Action


type alias Model =
  { form : Form.Types.Model
  , language : Language
  }


type GlobalCssClasses
  = Main


