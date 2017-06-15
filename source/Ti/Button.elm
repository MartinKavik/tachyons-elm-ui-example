module Ti.Button exposing (Model, Kind(..), Size(..), model, view, render, attributes, setDisabled, setReadonly, setKind, setSize, setText)

import Html.Events.Extra exposing (onKeys)
import Html.Events exposing (onClick)
import Html exposing (node, text)
import Html.Lazy
import Ui
import Tachyons exposing (..)
import Set exposing (Set)
import Ti.Ti as Ti


type alias Model =
    { disabled : Bool
    , readonly : Bool
    , kind : Kind
    , size : Size
    , text : String
    , identClass : String
    , classes : Set String
    }


type Kind
    = Primary
    | Secondary
    | Success
    | Warning
    | Danger


type Size
    = Small
    | Medium
    | Big


setDisabled : Bool -> Model -> Model
setDisabled value model =
    { model | disabled = value }


setReadonly : Bool -> Model -> Model
setReadonly value model =
    { model | readonly = value }


setKind : Kind -> Model -> Model
setKind value model =
    { model | kind = value }


setSize : Size -> Model -> Model
setSize value model =
    { model | size = value }


setText : String -> Model -> Model
setText value model =
    { model | text = value }


model : String -> Model
model identClass =
    { defaultModel | identClass = identClass }


defaultModel : Model
defaultModel =
    { disabled = False
    , readonly = False
    , kind = Primary
    , size = Medium
    , text = "X"
    , identClass = "ti-button"
    , classes = defaultRootClasses
    }


defaultRootClasses : Set String
defaultRootClasses =
    Set.fromList <|
        [ white
        , br2
        , b
        , dib
        , outline_0
        , overflow_hidden
        ]


view : msg -> Model -> Html.Html msg
view msg model =
    Html.Lazy.lazy2 render msg model


render : msg -> Model -> Html.Html msg
render msg model =
    let
        classesAttr : Html.Attribute msg
        classesAttr =
            model
                |> addDynamicRootClasses
                |> .classes
                |> Set.toList
                |> (::) model.identClass
                |> classes

        attrs : List (Html.Attribute msg)
        attrs =
            classesAttr
                :: attributes msg model
    in
        node
            "ui-button"
            attrs
            [ node "span" [] [ text model.text ]
            ]


addDynamicRootClasses : Model -> Model
addDynamicRootClasses model =
    let
        disabledAndKindClasses : List String
        disabledAndKindClasses =
            case model.disabled of
                False ->
                    [ "ripple", "pointer" ]
                        ++ case model.kind of
                            Primary ->
                                [ bg_blue ]

                            Secondary ->
                                [ bg_light_blue ]

                            Success ->
                                [ bg_green ]

                            Warning ->
                                [ bg_orange ]

                            Danger ->
                                [ bg_dark_red ]

                True ->
                    [ bg_gray ]

        sizeClasses : List String
        sizeClasses =
            case model.size of
                Small ->
                    [ ph2, pv1, f6 ]

                Medium ->
                    [ ph3, pv2, f5 ]

                Big ->
                    [ ph3, pv3, f4 ]

        allClasses : List String
        allClasses =
            disabledAndKindClasses ++ sizeClasses
    in
        Ti.addClasses allClasses model


attributes :
    msg
    -> { b | disabled : Bool, readonly : Bool }
    -> List (Html.Attribute msg)
attributes msg model =
    [ Ui.attributeList
        [ ( "disabled", model.disabled )
        ]
    , Ui.enabledActions model
        [ onClick msg
        , onKeys True
            [ ( 13, msg )
            , ( 32, msg )
            ]
        ]
    , Ui.tabIndex model
    ]
        |> List.concat
