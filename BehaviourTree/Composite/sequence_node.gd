## A composite node that process its children in sequence until one fails or stalls
## (Returns 'SUCCESS' if none of its children fails.)
class_name SequenceNode
extends CompositeNode


func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BTNode.Result:
    for child: BTNode in p_children:
        var result := child._on_behaviour_process(context)

        if (result == BTNode.RUNNING ||
            result == BTNode.FAIL):
            return result

    return BTNode.SUCCESS
