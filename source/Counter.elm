module Counter exposing (Model, Msg, init, update, view)

{-| A counter component.


# Model

@docs Model, Msg, init, update


# View

@docs view

-}

import Html.Attributes exposing (class)
import Html exposing (..)
import Ui.Button
import Tachyons exposing (..)
import Ti.Ti as Ti
import Ti.Button
import Set


{-| Representation of a counter.
-}
type alias Model =
    { counter : Int
    }


{-| Messages that a counter can receive.
-}
type Msg
    = Increment
    | Decrement


{-| Initializes a counter.
-}
init : Model
init =
    { counter = 0
    }


{-| Updates a counter.
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | counter = model.counter + 1 }, Cmd.none )

        Decrement ->
            ( { model | counter = model.counter - 1 }, Cmd.none )


{-| Renders a counter.
-}
view : Model -> Html.Html Msg
view model =
    div [ classes [ mw8_ns, center, ph4_ns, sans_serif ] ]
        [ article [ class ma4 ]
            [ Html.h1 [] [ text "Counter" ]
            , p []
                [ span [] [ text "This was an minimal project to get you started with" ]
                , span [ classes [ Tachyons.b, mh1 ] ] [ text "elm-dev-env" ]
                , span [] [ text "!" ]
                ]
            , div [ classes [ pv3, f4 ] ]
                [ span [] [ text "Counter:" ]
                , strong [ class ml2 ] [ text (toString model.counter) ]
                ]
            , hr [] []
            , scrollablePre []
                [ text
                    """-- Original Elm-UI
[ Ui.Button.view Decrement (Ui.Button.model "- Decrement" "primary" "medium")
, Ui.Button.view Increment (Ui.Button.model "+ Increment" "primary" "medium")
]"""
                ]
            , div [ class "buttons-original" ]
                [ Ui.Button.view Decrement (Ui.Button.model "- Decrement" "primary" "medium")
                , Ui.Button.view Increment (Ui.Button.model "+ Increment" "primary" "medium")
                ]
            , hr [ class mt5 ] []
            , scrollablePre []
                [ text
                    """[ Ti.Button.model "btn-increment"
    |> Ti.addClasses [ mr2 ]     -- margin-right
    |> Ti.Button.setText "- Decrement"
    |> Ti.Button.view Decrement
, Ti.Button.model "btn-decrement"
    |> Ti.addClasses [ mt2 ]     -- margin-top
    |> Ti.Button.setText "+ Increment"
    |> Ti.Button.view Increment
]"""
                ]
            , div [ class "buttons-new" ]
                [ Ti.Button.model "btn-increment"
                    |> Ti.addClasses [ mr2 ]
                    |> Ti.Button.setText "- Decrement"
                    |> Ti.Button.view Decrement
                , Ti.Button.model "btn-decrement"
                    |> Ti.addClasses [ mt2 ]
                    |> Ti.Button.setText "+ Increment"
                    |> Ti.Button.view Increment
                ]
            , hr [ class mt5 ] []
            , scrollablePre []
                [ text
                    """[ Ti.Button.model "btn-1"
    |> Ti.Button.setText "- Decrement"
    |> Ti.Button.setKind Ti.Button.Danger
    |> Ti.Button.setSize Ti.Button.Small
    |> Ti.Button.view Decrement
, Ti.Button.model "btn-2"
    |> Ti.removeClasses [ white ]
    |> Ti.addClasses [ ml2, mt2, ttu ]
    |> Ti.Button.setText "+ Increment"
    |> Ti.Button.setKind Ti.Button.Success
    |> Ti.Button.setSize Ti.Button.Big
    |> Ti.Button.view Increment
]"""
                ]
            , div [ class "buttons-new2" ]
                [ Ti.Button.model "btn-1"
                    |> Ti.Button.setText "- Decrement"
                    |> Ti.Button.setKind Ti.Button.Danger
                    |> Ti.Button.setSize Ti.Button.Small
                    |> Ti.Button.view Decrement
                , Ti.Button.model "btn-2"
                    |> Ti.removeClasses [ white ]
                    |> Ti.addClasses [ ml2, mt2, ttu ]
                    |> Ti.Button.setText "+ Increment"
                    |> Ti.Button.setKind Ti.Button.Success
                    |> Ti.Button.setSize Ti.Button.Big
                    |> Ti.Button.view Increment
                ]
            , hr [ class mt5 ] []
            , scrollablePre []
                [ text
                    """[ Ti.Button.model "btn-1"
    |> Ti.addClasses [ mr2, ba, bw1, b__dark_blue ]
    |> Ti.Button.setText "- Decrement"
    |> Ti.Button.view Decrement
, Ti.Button.model "btn-2"
    |> Ti.transformClasses (\\cls -> cls |> Set.union (Set.fromList [ mt2, ba, bw1, b__dark_gray ]))
    |> Ti.transformModel (\\m -> { m | text = "+ Increment" })
    |> Ti.Button.setDisabled True
    |> Ti.Button.view Increment
]"""
                ]
            , div [ class "buttons-new3" ]
                [ Ti.Button.model "btn-1"
                    |> Ti.addClasses [ mr2, ba, bw1, b__dark_blue ]
                    |> Ti.Button.setText "- Decrement"
                    |> Ti.Button.view Decrement
                , Ti.Button.model "btn-2"
                    |> Ti.transformClasses (\cls -> cls |> Set.union (Set.fromList [ mt2, ba, bw1, b__dark_gray ]))
                    |> Ti.transformModel (\m -> { m | text = "+ Increment" })
                    |> Ti.Button.setDisabled True
                    |> Ti.Button.view Increment
                ]
            ]
        ]



-- Helpers


scrollablePre : List (Html.Attribute msg) -> List (Html msg) -> Html msg
scrollablePre attrs =
    Html.pre ([ class overflow_auto ] ++ attrs)
