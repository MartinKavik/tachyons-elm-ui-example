module Ti.Ti exposing (..)

import Set exposing (Set)
import Function.Extra


type alias RecordWithClasses r =
    { r | classes : Set String }


transformModel : (record -> record) -> record -> record
transformModel =
    Function.Extra.twice


transformClasses : (Set String -> Set String) -> RecordWithClasses r -> RecordWithClasses r
transformClasses classesTransformer record =
    { record | classes = classesTransformer record.classes }


addClasses : List String -> RecordWithClasses r -> RecordWithClasses r
addClasses newClasses record =
    { record
        | classes =
            Set.union
                record.classes
                (Set.fromList newClasses)
    }


removeClasses : List String -> RecordWithClasses r -> RecordWithClasses r
removeClasses classesForRemove record =
    { record
        | classes =
            Set.diff
                record.classes
                (Set.fromList classesForRemove)
    }
