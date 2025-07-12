## A special behaviour node that always returns success when evaluated
## Unlike an [[ActionNode]], it does not require its callback method to
## provide a parameter for the context dict. Its primary purpose is to
## provide a way to quickly trigger methods during certain behaviour branches.
class_name CallbackNode
extends BTNode

var p_callback: Callable

func _init(callback: Callable) -> void:
    assert(callback.is_valid(), "CallbackNode: invalid function assigned")
    p_callback = callback


#region Events

func _on_behaviour_process(_context: Dictionary[StringName, Variant]) -> BTNode.Result:
    p_callback.call()
    return BTNode.SUCCESS

#endregion
