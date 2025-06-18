## A generalised action evaluator for 2D NPCs
class_name ActionEvaluator2D
extends BaseActionEvaluator


#region Evaluator

## Runs the evaluator process
## Distance is automatically derived from the relative position
## (Use global_scale for [[scale_mod]], [[dot]] is completely optional)
## (Returns null if no actions were picked.)
func evaluate(relative_position: Vector2,
              facing_left: bool,
              scale_mod: float,
              dot: float = 0.0) -> ActionEvaluator2DResult:

    p_access_index.shuffle()

    for i: int in p_access_index:
        var action: EvaluatorAction2D = p_actions[i]

        if !action.evaluate(p_flags, relative_position, facing_left, scale_mod, dot):
            continue

        __trigger_callback(action.p_callback)
        return action.as_result()

    return null

#endregion
