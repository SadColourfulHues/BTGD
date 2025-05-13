## (BehaviourTreeNode)
## The base BT node class, subclass to implement custom behaviour
class_name BTNode
extends Object

##region Result

enum Result
{
    SUCCESS,
    FAIL,
    RUNNING
}

# Shorthands #

const SUCCESS := Result.SUCCESS
const FAIL := Result.FAIL
const RUNNING := Result.RUNNING

#endregion

#region Events

## This function is called when the node is about to be deallocated,
## use it to perform cleanup on non ref-counted objects
func _on_behaviour_deinit() -> void:
    pass


## The behaviour node's processing function
@warning_ignore("UNUSED_PARAMETER")
func _on_behaviour_process(context: Dictionary[StringName, Variant]) -> Result:
    return SUCCESS

#endregion

#region Utils

func get_owner(context: Dictionary[StringName, Variant]) -> Node:
    return context[BehaviourTree.BTK_TREE_OWNER]

#endregion
