module Main (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, targetValue, on)
import String exposing (toInt)
import Effects exposing (Effects)
import StartApp


-- APP KICK OFF!


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [ Signal.map (always NoOp) swap ]
    }


main =
  app.html



-- HOT-SWAPPING


port swap : Signal.Signal Bool



-- MODEL


type alias Model =
  { email : String
  , windSpeed : String
  }


initalModel : Model
initalModel =
  { email = ""
  , windSpeed = "11"
  }



-- INIT


init =
  ( initalModel, Effects.none )


view address model =
  div
    []
    [ h1 [] [ text "Never Miss a Windy Day Again." ]
    , Html.form
        [ id "signup-form" ]
        [ div
            [ class "form-field" ]
            [ label [] [ text "Email" ]
            , input
                [ id "username-field"
                , type' "text"
                , placeholder "your-email@gmail.com"
                , on "input" targetValue (Signal.message address << SetEmail)
                , value model.email
                ]
                []
            ]
        , div
            [ class "form-field" ]
            [ label [] [ text "Select Country" ]
            , select
                []
                [ option [ id "1" ] [ text "Argentina" ]
                , option [ id "2" ] [ text "Spain" ]
                ]
            ]
        , div
            [ class "form-field" ]
            [ label [] [ text "Minimum Wind Speed (in knots)" ]
            , input
                [ type' "number"
                , value model.windSpeed
                , on "input" targetValue (Signal.message address << SetWindSpeed)
                ]
                []
            ]
        ]
    ]



-- UPDATE


type Action
  = NoOp
  | SetEmail String
  | SetWindSpeed String


update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    SetEmail str ->
      ( { model
          | email = str
        }
      , Effects.none
      )

    SetWindSpeed str ->
      ( { model
          | windSpeed = str
        }
      , Effects.none
      )
