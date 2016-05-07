module Form.Rest (..) where

import Form.Types exposing (..)
import AvailableDays.Types exposing (dayToStr)
import Http
import Json.Encode as JE
import Json.Decode exposing (Decoder, object1, object2, object3, object4, list, succeed, string, float, int, (:=))
import Effects exposing (Effects)
import Task


baseUrl : String
baseUrl =
  "http://www.vient.us"


getCountries : Effects Action
getCountries =
  Http.get countriesListDecoder (baseUrl ++ "/countries.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetCountries list)
    |> Effects.task


countriesListDecoder : Decoder (List Country)
countriesListDecoder =
  list countryDecoder


countryDecoder : Decoder Country
countryDecoder =
  object2 Country
    ("name" := string)
    ("id" := string)


getRegions : String -> Effects Action
getRegions countryId =
  Http.get regionsListDecoder (baseUrl ++ "/countries/" ++ countryId ++ "/regions.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetRegions list)
    |> Effects.task


regionsListDecoder : Decoder (List Region)
regionsListDecoder =
  list regionDecoder


regionDecoder : Decoder Region
regionDecoder =
  object2 Region
    ("name" := string)
    ("id" := string)


getCountrySpots : String -> Effects Action
getCountrySpots countryId =
  Http.get spotsListDecoder (baseUrl ++ "/countries/" ++ countryId ++ "/spots.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetSpots list)
    |> Effects.task


getRegionSpots : String -> Effects Action
getRegionSpots regionId =
  Http.get spotsListDecoder (baseUrl ++ "/regions/" ++ regionId ++ "/spots.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetSpots list)
    |> Effects.task


spotsListDecoder : Decoder (List Spot)
spotsListDecoder =
  list spotDecoder


spotDecoder : Decoder Spot
spotDecoder =
  object4 Spot
    ("name" := string)
    ("id" := string)
    ("latitude" := float)
    ("latitude" := float)


submitParams : SubmitModel -> List ( String, String )
submitParams submitModel =
  List.append
    (List.map (\wd -> ( "alert[wind_directions][]", toString wd )) submitModel.windDirections)
    (List.map (\day -> ( "alert[dates][]", dayToStr day )) submitModel.availableDays.days)
    |> List.append
        [ ( "alert[user_attributes][locale]", "EN" )
        , ( "alert[user_attributes][email]", submitModel.email )
        , ( "alert[spot_id]", submitModel.selectedSpotId )
        , ( "alert[min_speed]", submitModel.windSpeed )
        , ( "elm", "true" )
        ]


encodedUrl : SubmitModel -> String
encodedUrl submitModel =
  Http.url (baseUrl ++ "/alerts") (submitParams submitModel)



submitAlert : SubmitModel -> Effects Action
submitAlert submitModel =
  Http.post submitDecoder (encodedUrl submitModel) Http.empty
    |> (flip Task.onError) (\err -> Task.succeed SubmitFailure  )
    |> Effects.task 


{-
    Http.post submitDecoder (encodedUrl submitModel) Http.empty
      |> Task.toResult
      |> Task.map (\result -> NoOp )
      |> Effects.task
-}



submitDecoder : Decoder Action
submitDecoder =
  succeed SubmitSuccess
