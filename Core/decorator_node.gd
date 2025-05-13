## The base-class for nodes that modify the behaviour of other nodes
class_name DecoratorNode
extends BTNode

var p_wrapped: BTNode


func _init(target: BTNode) -> void:
    p_wrapped = target


#region Events

func _on_behaviour_deinit() -> void:
    p_wrapped._on_behaviour_deinit()


func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> Result:
    return p_wrapped._on_behaviour_process(context)

#endregion
