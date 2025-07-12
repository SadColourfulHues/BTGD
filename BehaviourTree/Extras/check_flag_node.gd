## This conditional node returns SUCCESS if the specified flag exists in the context
class_name CheckFlagNode
extends BTNode

var m_flag: StringName
var m_check_target: bool


func _init(flag: StringName, check_target: bool = true) -> void:
    m_flag = flag
    m_check_target = check_target


#region Events

func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BTNode.Result:
    if (m_check_target == context.get(m_flag, false)):
        return BTNode.SUCCESS

    return BTNode.FAIL

#endregion
