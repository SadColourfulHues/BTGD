## A special behaviour node that always returns success when evaluated
## Unlike an [[ActionNode]], it does not require its callback method to
## provide a parameter for the context dict. Its primary purpose is to
## provide a way to quickly trigger methods during certain behaviour branches.
class_name CallbackNode
extends BehaviourNode

var p_callback: Callable

func _init(callback: Callable) -> void:
    p_callback = callback


#region Events

func _on_behaviour_process(_context: Dictionary[StringName, Variant]) -> BehaviourNode.Result:
    p_callback.call()
    return BehaviourNode.Result.SUCCESS

#endregion
