module App.Types (..) where

import Form.Types


type Action
  = NoOp
  | Form Form.Types.Action


type alias Model =
  { form : Form.Types.Model
  }


type GlobalCssClasses
  = Main


type CssClasses
  = FormSection
  | Sidebar
