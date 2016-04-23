module Form.Rest (..) where

import Form.Types exposing (..)
import WindDirection.Types exposing (wdToStr)
import AvailableDays.Types exposing (dayToStr)
import Http
import Json.Encode as JE
import Json.Decode.Extra exposing ((|:))
import Json.Decode exposing (Decoder, list, succeed, string, float, int, (:=))
import Effects exposing (Effects)
import Task


getCountries : Effects Action
getCountries =
  Http.get countriesListDecoder "http://localhost:3000/countries.json"
    |> Task.toMaybe
    |> Task.map (\list -> SetCountries list)
    |> Effects.task


countriesListDecoder : Decoder (List Country)
countriesListDecoder =
  list countryDecoder


countryDecoder : Decoder Country
countryDecoder =
  succeed Country
    |: ("name" := string)
    |: ("id" := string)


getRegions : String -> Effects Action
getRegions countryId =
  Http.get regionsListDecoder ("http://localhost:3000/countries/" ++ countryId ++ "/regions.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetRegions list)
    |> Effects.task


regionsListDecoder : Decoder (List Region)
regionsListDecoder =
  list regionDecoder


regionDecoder : Decoder Region
regionDecoder =
  succeed Region
    |: ("name" := string)
    |: ("id" := string)


getCountrySpots : String -> Effects Action
getCountrySpots countryId =
  Http.get spotsListDecoder ("http://localhost:3000/countries/" ++ countryId ++ "/spots.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetSpots list)
    |> Effects.task


getRegionSpots : String -> Effects Action
getRegionSpots regionId =
  Http.get spotsListDecoder ("http://localhost:3000/regions/" ++ regionId ++ "/spots.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetSpots list)
    |> Effects.task


spotsListDecoder : Decoder (List Spot)
spotsListDecoder =
  list spotDecoder


spotDecoder : Decoder Spot
spotDecoder =
  succeed Spot
    |: ("name" := string)
    |: ("id" := string)
    |: ("latitude" := float)
    |: ("latitude" := float)


submitAlert formModel =
  Http.post submitDecoder ("http://localhost:3000/alerts") (encodedAlert formModel)


encodedAlert : SubmitModel -> Http.Body
encodedAlert submitModel =
  JE.encode 0 (alertObject submitModel)
    |> Http.string



{-
"alert"=>{"user_attributes"=>{"locale"=>"en", "email"=>"pepe@pepe.com"}, "country_id"=>"113", "region_id"=>"", "spot_id"=>"15342", "min_speed"=>"11", "wind_directions"=>["N", "NE"], "dates"=>["5", "6", ""]}
-}


alertObject : SubmitModel -> JE.Value
alertObject submitModel =
  JE.object
    [ ( "alert"
      , JE.object
          [ ( "spot_id", JE.string submitModel.selectedSpot.id )
          , ( "min_speed", JE.string submitModel.windSpeed )
          , ( "user_attributes"
            , JE.object
                [ ( "locale", JE.string "en" )
                , ( "email", JE.string submitModel.email )
                ]
            )
          , ( "dates"
            , JE.list
                (List.map (\day -> JE.string (dayToStr day)) submitModel.availableDays.days)
            )
          , ( "wind_directions"
            , JE.list
                (List.map (\windDir -> JE.string (wdToStr windDir)) submitModel.windDirections)
            )
          ]
      )
    ]



-- This code is not correct


submitDecoder : Decoder ()
submitDecoder =
  succeed ()
