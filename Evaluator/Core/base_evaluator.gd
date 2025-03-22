## Base class that provides core functionality needed for action evaluators
## (Subclasses should implement the [_evaluate] method for consistency.)
## (Make sure to free it after use!)
class_name BaseActionEvaluator
extends Object

## Shared pseudorandom generator for chance-based calculations
static var p_rng := RandomNumberGenerator.new()

## When set to true, action callbacks are automatically called when picked
var m_auto_callback: bool = true

## An array containing all currently-set flags in the evaluator
var p_flags: Array[StringName]

## An array containing all possible actions in the evaluator.
## (Do not set directly, use the [set_actions] method to properly update the evaluator.)
var p_actions: Array

## A pre-allocated array that is used to store index access sequence during an evaluation
## (Do not use for anything else or regenerate its contents. Call 'shuffle' to randomise
## access order before evaluation.)
var p_access_index: Array[int]


#region Events

func _notification(what: int) -> void:
    # Ensure everything is freed (as most evaluator objects are not a reference-counted)
    if what != NOTIFICATION_PREDELETE:
        return

    for action: BaseEvaluatorAction in p_actions:
        action.free()

#endregion

#region Functions

## Updates the evaluator's action set
func set_actions(actions: Array) -> void:
    p_actions = actions

    # Re-generate access index #
    var new_size := actions.size()

    if p_access_index.size() == new_size:
        return

    p_access_index.resize(new_size)

    for i: int in range(new_size):
        p_access_index[i] = i


## Sets a flag in the evaluator
func flag(flag_id: StringName) -> void:
    if p_flags.has(flag_id):
        return

    p_flags.append(flag_id)


## Removes a flag from the evaluator
func unflag(flag_id: StringName) -> void:
    p_flags.erase(flag_id)

#endregion

#region Utils

func __trigger_callback(callback: Callable) -> void:
    if !m_auto_callback || !callback.is_valid():
        return

    callback.call()


## Returns true for successful rolls
## (Expected range 0.0 - 1.0)
static func chance(probability: float) -> bool:
    return p_rng.randf() <= probability

#endregion
