## A special behaviour node that delegates its processing to a specified method using [Callable]
## (This node assumes that the callback method takes a context dict (StringName / Variant pair)
## as an input, and returns a [BTNode.Result]).
## --
## tldr. this is basically a catch-all behaviour node that can do most of the basic
## custom processing needed by AI agents to function.

class_name ActionNode
extends BTNode

var p_callback: Callable


func _init(callback: Callable) -> void:
    p_callback = callback


#region Events

func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> BTNode.Result:
    return p_callback.call(context)

#endregion
