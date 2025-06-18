## An object representing the output of a [[ActionEvaluator2D]]
class_name ActionEvaluator2DResult
extends RefCounted

## The action's associated animation ID
var m_action_id: StringName
## The amount to multiply the animation lock length with
var m_lock_mod: float
## The amount of time wanted by the action to turn the object to its target (game-specific)
var m_turn_secs: float

## Callback associated with this action
var p_callback: Callable


#region Utils

## Copies data from another result
## Override this on 2D evaluator result subclasses to add additional parameters
## and use this method in [[as_result]] to quickly copy data from the superclass's default
func copy_from(result) -> void:
    m_action_id = result.m_action_id
    m_lock_mod = result.m_lock_mod
    m_turn_secs = result.m_turn_secs
    p_callback = result.p_callback

#endregion
