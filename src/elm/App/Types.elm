module App.Types exposing (..)

import Form.Types


type Action
  = NoOp
  | Form Form.Types.Action


type alias Model =
  { form : Form.Types.Model
  }


type GlobalCssClasses
  = Main


