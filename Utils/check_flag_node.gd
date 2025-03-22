## This conditional node returns SUCCESS if the specified flag exists in the context
## Set [unflag_mode] to true to invert its behaviour.
class_name CheckFlagNode
extends BehaviourNode

var m_flag: StringName
var m_check_target: bool


func _init(flag: StringName, unflag_mode: bool = false) -> void:
    m_flag = flag
    m_check_target = !unflag_mode


#region Events

func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BehaviourNode.Result:
    return BTUtils.b2r(context.has(m_flag) && context[m_flag] == m_check_target)

#endregion
