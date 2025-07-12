## A utility behaviour node that sets a variable in the context when ran
class_name SetVarNode
extends BTNode

var m_key: StringName
var m_value: Variant


func _init(key: StringName, value: Variant) -> void:
    m_key = key
    m_value = value


#region Events

func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BTNode.Result:
    context[m_key] = m_value
    return BTNode.SUCCESS

#endregion
