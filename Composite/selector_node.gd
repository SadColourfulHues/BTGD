## A composite node that process its children in sequence until one succeeds or stalls
## (Returns 'FAIL' if none of its children returns.)
class_name SelectorNode
extends CompositeNode


func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BTNode.Result:
    for child: BTNode in p_children:
        var result := child._on_behaviour_process(context)

        if (result == BTNode.RUNNING ||
            result == BTNode.SUCCESS):
            return result

    return BTNode.FAIL
