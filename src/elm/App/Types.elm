module App.Types exposing (..)

import Form.Types


type Msg
  = NoOp
  | Form Form.Types.Msg


type alias Model =
  { form : Form.Types.Model
  }


type GlobalCssClasses
  = Main


