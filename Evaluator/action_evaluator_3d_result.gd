## An object representing the output of a [ActionEvaluator3D]
class_name ActionEvaluator3DResult
extends RefCounted

## The action's associated animation ID
var m_action_id: StringName
## The tick duration to lock the object down for the selected action
var m_lock_duration: float
## Root motion scale for the selected action
var m_rm_scale: float
## The amount of time wanted by the action to turn the object to its target (game-specific)
var m_turn_secs: float

## Callback associated with this action
var p_callback: Callable
