## A simple variant of the SetVarNode that uses an ID/boolean pair
## Set [unflag_mode] in its constructor to perform an unflag.
class_name FlagNode
extends SetVarNode


func _init(key: StringName, unflag_mode: bool = false) -> void:
    super._init(key, !unflag_mode)