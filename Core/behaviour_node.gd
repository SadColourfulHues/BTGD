## The base BT node class, subclass to implement custom behaviour
class_name BehaviourNode
extends Object

enum Result
{
    SUCCESS,
    FAIL,
    RUNNING
}

#region Events

## This function is called when the node is about to be deallocated,
## use it to perform cleanup on non ref-counted objects
func _on_behaviour_deinit() -> void:
    pass


## The behaviour node's processing function
@warning_ignore("UNUSED_PARAMETER")
func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> Result:
    return Result.SUCCESS

#endregion

#region Utils

func get_owner(context: Dictionary[StringName, Variant]) -> Node:
    return context[BehaviourTree.BTK_TREE_OWNER]

#endregion