module Form.Rest (..) where

import Form.Types exposing (..)
import Http
import Json.Encode as Json
import Json.Decode.Extra exposing ((|:))
import Json.Decode exposing (Decoder, list, succeed, string, int, (:=))
import Effects exposing (Effects)
import Task


getCountries =
  Http.get countriesListDecoder "http://localhost:3000/countries.json"
    |> Task.toMaybe
    |> Task.map (\list -> SetCountries list)
    |> Effects.task


countriesListDecoder =
  list countryDecoder


countryDecoder : Decoder Country
countryDecoder =
  succeed Country
    |: ("name" := string)
    |: ("id" := string)
