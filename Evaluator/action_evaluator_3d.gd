## A generalised action evaluator for 3D NPCs
class_name ActionEvaluator3D
extends BaseActionEvaluator


#region Evaluator

## Runs the evaluator process
## (Returns null if no actions were picked.)
func evaluate(distance: float,
    dot: float,
    left_side: bool,
    scale_modifier: float) -> ActionEvaluator3DResult:

    p_access_index.shuffle()

    for i: int in p_access_index:
        var action: EvaluatorAction3D = p_actions[i]

        if !action.evaluate(p_flags, distance, dot, scale_modifier):
            continue

        action.trigger_callback()
        return action.as_result(left_side)

    return null

#endregion