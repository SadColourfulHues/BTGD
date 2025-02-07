## Base class for all evaluator actions
## (Subclasses should implement the [_evaluate -> bool] method for the sake of consistency.)
class_name BaseEvaluatorAction
extends Object

var m_chance: float
var p_required_flags: Array[StringName]
var p_flag_chance_modifier: Dictionary[StringName, float]
var p_callback: Callable


func _init(chance_probability: float) -> void:
    m_chance = chance_probability
    p_callback = Callable()


#region Setters

## Sets the probability of this action being picked
## (Expected range: 0.0 - 1.0)
func chance(probability: float) -> BaseEvaluatorAction:
    m_chance = probability
    return self


## Triggers the specified method when this action has been picked
func callback(method: Callable) -> BaseEvaluatorAction:
    p_callback = method
    return self


## Makes it so that this action can only be picked when the specified flag is set
func requires_flag(flag_id: StringName) -> BaseEvaluatorAction:
    p_required_flags = [flag_id]
    return self


## Makes it so that this action can only be picked when all the specified flags are set
func requires_flags(flags: Array[StringName]) -> BaseEvaluatorAction:
    p_required_flags = flags
    return self


## Adds a chance modifier when the specific flag is set
func flag_chance_mod(flag_id: StringName, amount: float) -> BaseEvaluatorAction:
    p_flag_chance_modifier[flag_id] = amount
    return self

#endregion

#region Utils

## Returns the final chance value for this action
func get_chance(evaluator_flags: Array[StringName]) -> float:
    var true_Chance := m_chance

    # Apply chance modifiers
    for flag_mod: StringName in p_flag_chance_modifier:
        if !evaluator_flags.has(flag_mod):
            continue

        true_Chance = clamp(true_Chance + p_flag_chance_modifier[flag_mod], 0.0, 1.0)

    return true_Chance


## Returns true if all its required flags are in the evaluator
func flags_satisfied(flags: Array[StringName]) -> bool:
    if p_required_flags.is_empty():
        return true

    for flag: StringName in p_required_flags:
        if !flags.has(flag):
            return false

    return true


## Triggers the action's associated callback method
func trigger_callback() -> void:
    if !p_callback.is_valid():
        return

    p_callback.call()


#endregion