## A decorator node that inverts the result of its target
class_name InverterNode
extends DecoratorNode


func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BehaviourNode.Result:
    var result := p_wrapped._on_behaviour_process(context)

    if result == BehaviourNode.Result.RUNNING:
        return result

    return (
        BehaviourNode.Result.FAIL
        if result == BehaviourNode.Result.SUCCESS
        else BehaviourNode.Result.SUCCESS
    )