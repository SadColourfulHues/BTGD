@warning_ignore_start("shadowed_variable")

## An object representing an action for a [[ActionEvaluator2D]]
## (Best used with SCHLibGD's [[SpriteAnimator2D]]
class_name EvaluatorAction2D
extends BaseEvaluatorAction

var m_action_id: StringName
var m_lock_mod: float

var m_turn_to_target_secs: float

var m_min_distance: float
var m_max_distance: float

var m_y_max_distance: float

var m_do_dot_checks: bool
var m_dot_lequal: bool
var m_dot: float

var m_do_facing_test: bool
var m_facing_test_inverted: bool

var m_do_above_test: bool
var m_above_test_inverted: bool


func _init(action_id: StringName,
           chance_probability: float,
           lock_mod: float = 1.0,
           max_distance: float = INF) -> void:

    super._init(chance_probability)

    m_action_id = action_id
    m_lock_mod = lock_mod

    m_turn_to_target_secs = 0.0
    m_min_distance = 0.0
    m_max_distance = max_distance
    m_y_max_distance = 0.0

    m_do_dot_checks = false
    m_dot_lequal = false
    m_dot = 0.0

    m_do_facing_test = false
    m_facing_test_inverted = false
    m_do_above_test = false
    m_above_test_inverted = false


#region Action

func evaluate(flags: Array[StringName],
              relative_position: Vector2,
              facing_left: bool,
              scale_mod: float = 1.0,
              view_dot: float = 0.0) -> bool:

    # Viability checks #

    if (!flags_satisfied(flags) ||
        !BaseActionEvaluator.chance(get_chance(flags))):
        return false

    # Spatial checks #

    var distance: float = 0.5 * (abs(relative_position.x) + abs(relative_position.y))

    if (distance < (m_min_distance * scale_mod) ||
        distance > (m_max_distance * scale_mod)):
        return false

    if m_do_dot_checks && (
        (m_dot_lequal && view_dot > m_dot) ||
        (!m_dot_lequal && view_dot < m_dot)):
        return false

    # Relative Spatial Checks #

    if (m_do_above_test && !(
            (m_above_test_inverted && relative_position.y > 0.0) ||
            (!m_above_test_inverted && relative_position.y < 0.0))):
        return false

    var relydist: float = abs(scale_mod * m_y_max_distance)

    if (!is_zero_approx(relydist) && !(
            relative_position.y >= -relydist &&
            relative_position.y <= relydist)):
        return false

    var facing_sign := -1.0 if facing_left else 1.0

    if m_facing_test_inverted:
        facing_sign *= -1.0

    if m_do_facing_test && sign(relative_position.x) != facing_sign:
        return false

    return true


func as_result() -> ActionEvaluator2DResult:
    var result := ActionEvaluator2DResult.new()

    result.m_action_id = m_action_id
    result.m_lock_mod = m_lock_mod
    result.m_turn_secs = m_turn_to_target_secs
    result.p_callback = p_callback

    return result

#endregion

#region Setters

## Adds a Y distance restriction to this action
## (Useful for sides-only top-down schemes)
func restrict_y_distance(y_distance: float) -> EvaluatorAction2D:
    m_y_max_distance = y_distance
    return self


## Adds a minimum distance requirement to this action
func min_distance(distance: float) -> EvaluatorAction2D:
    m_min_distance = distance
    return self


## Adds a maximum distance requirement to this action
func max_distance(distance: float) -> EvaluatorAction2D:
    m_max_distance = distance
    return self


## Adds a visibility check where the relative x position must
## fall within the expected sign (depending on the agent's current facing direction.)
## (Useful for sides-only top-down schemes)
func is_facing(invert: bool = false) -> EvaluatorAction2D:
    m_do_facing_test = true
    m_facing_test_inverted = invert
    return self


## Adds a restriction where the relative y must be
## on the negative side of the agent's current y position
func is_above(invert: bool = false) -> EvaluatorAction2D:
    m_do_above_test = true
    m_above_test_inverted = invert
    return self


## Adds a min/max dot requirement to this action
## (Useful for top-down games)
## (Common values: -0.5 ... 0.0 => side, > 0.5 = front, -0.5 = back)
func dot(value: float, lequal_mode: bool = false) -> EvaluatorAction2D:
    m_do_dot_checks = true
    m_dot = value
    m_dot_lequal = lequal_mode
    return self


## Adds a turn request when activated with the specified duration
## (Useful for top-down games)
func turn_to_target(secs: float) -> EvaluatorAction2D:
    m_turn_to_target_secs = secs
    return self

#endregion
