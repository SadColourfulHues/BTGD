## A composite node that process its children in sequence until one fails or stalls
## (Returns 'SUCCESS' if none of its children fails.)
class_name SequenceNode
extends CompositeNode


func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BehaviourNode.Result:
    for child: BehaviourNode in p_children:
        var result := child._on_behaviour_process(context)

        if (result == BehaviourNode.Result.RUNNING ||
            result == BehaviourNode.Result.FAIL):
            return result

    return BehaviourNode.Result.SUCCESS
