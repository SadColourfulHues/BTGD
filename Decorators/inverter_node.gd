## A decorator node that inverts the result of its target
class_name InverterNode
extends DecoratorNode


func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BTNode.Result:
    return BTUtils.invert(p_wrapped._on_behaviour_process(context))
