## Sets/unsets a behaviour flag in the processing context
## (Try to limit where this is used. aka. treat it like a callback node
## i.e. end of conditional chains to reduce write costs.)
class_name FlagNode
extends BTNode

var m_key: StringName
var m_flag_mode: bool


func _init(key: StringName, flag_mode: bool) -> void:
    m_key = key
    m_flag_mode = flag_mode


#region Events

func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BTNode.Result:
    if m_flag_mode:
        context[m_key] = true
    else:
        context.erase(m_key)

    return BTNode.SUCCESS
