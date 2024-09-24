## A composite node that process its children in sequence until one succeeds or stalls
## (Returns 'FAIL' if none of its children returns.)
class_name SelectorNode
extends CompositeNode


func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BehaviourNode.Result:
    for child: BehaviourNode in p_children:
        var result := child._on_behaviour_process(context)

        if (result == BehaviourNode.Result.RUNNING ||
            result == BehaviourNode.Result.SUCCESS):
            return result

    return BehaviourNode.Result.FAIL
