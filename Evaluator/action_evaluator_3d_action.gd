@warning_ignore_start("shadowed_variable")

## An object representing an action for a [ActionEvaluator3D]
## (Best used with SCHLibGD's [Animator])
class_name EvaluatorAction3D
extends BaseEvaluatorAction

var m_action_id: StringName
var m_rm_scale: float
var m_lock_duration: float

var m_turn_to_target_secs: float

var m_min_distance: float
var m_max_distance: float

var m_dot: float
var m_dot_lequal: bool
var m_do_dot_checks: bool

var m_other_side_id: StringName


func _init(action_id: StringName,
        chance_probability: float,
        lock_duration: float,
        max_distance: float = INF,
        rm_scale: float = 1.0) -> void:

    super._init(chance_probability)

    m_action_id = action_id
    m_rm_scale = rm_scale

    m_min_distance = 0.0
    m_max_distance = max_distance * max_distance

    m_lock_duration = lock_duration

    m_dot = 0.0
    m_do_dot_checks = false
    m_dot_lequal = false

    m_other_side_id = action_id


#region Action

## Returns true if the action is successfully picked
func evaluate(flags: Array[StringName],
            distance: float,
            view_dot: float,
            scale_modifier: float = 1.0) -> bool:

    # Viability checks #
    if (!flags_satisfied(flags) ||
        !BaseActionEvaluator.chance(get_chance(flags))):

        return false

    # Spatial checks #
    if (distance < (m_min_distance * scale_modifier) ||
        distance > (m_max_distance * scale_modifier)):

        return false

    if m_do_dot_checks && (
        (m_dot_lequal && view_dot > m_dot) ||
        (!m_dot_lequal && view_dot < m_dot)):

        return false

    return true


func as_result(left_side: bool) -> ActionEvaluator3DResult:
    var result := ActionEvaluator3DResult.new()

    result.m_action_id = m_other_side_id if left_side else m_action_id
    result.m_lock_duration = m_lock_duration
    result.m_rm_scale = m_rm_scale
    result.m_turn_secs = m_turn_to_target_secs
    result.p_callback = p_callback

    return result

#endregion

#region Setters

## Adds an alternate animation when the target is on the opposite side
## (Useful for side actions. e.g. attack_l | attack_r)
func other_side_id(alt_id: StringName) -> EvaluatorAction3D:
    m_other_side_id = alt_id
    return self


## Adds a minimum distance requirement to this action
func min_distance(distance: float) -> EvaluatorAction3D:
    m_min_distance = distance * distance
    return self


## Adds a maximum distance requirement to this action
func max_distance(distance: float) -> EvaluatorAction3D:
    m_max_distance = distance * distance
    return self

## Adds a root motion scale modifier to this action
func rm_scale(scale: float) -> EvaluatorAction3D:
    m_rm_scale = scale
    return self


## Adds a min/max dot requirement to this action
## (Common values: -0.5 ... 0.0 => side, > 0.5 = front, -0.5 = back)
func dot(value: float, lequal_mode: bool = false) -> EvaluatorAction3D:
    m_do_dot_checks = true
    m_dot = value
    m_dot_lequal = lequal_mode
    return self


## Adds a turn request when activated with the specified duration
func turn_to_target(secs: float) -> EvaluatorAction3D:
    m_turn_to_target_secs = secs
    return self


#endregion
