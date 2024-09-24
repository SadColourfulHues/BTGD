## The base-class for nodes that modify the behaviour of other nodes
class_name DecoratorNode
extends BehaviourNode

var p_wrapped: BehaviourNode


func _init(target: BehaviourNode) -> void:
    p_wrapped = target


#region Events

func _on_behaviour_deinit() -> void:
    p_wrapped._on_behaviour_deinit()


func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> Result:
    return p_wrapped._on_behaviour_process(context)

#endregion