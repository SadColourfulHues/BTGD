class_name BTUtils
extends Object


#region Functions

## Returns success if condition is true
static func b2r(condition: bool,
           fail_output := BehaviourNode.Result.FAIL) -> BehaviourNode.Result:

    return BehaviourNode.Result.SUCCESS if condition else fail_output


## Inverts the value of [base]
static func invert(base: BehaviourNode.Result) -> BehaviourNode.Result:
    match base:
        BehaviourNode.Result.SUCCESS:
            return BehaviourNode.Result.FAIL
        BehaviourNode.Result.FAIL:
            return BehaviourNode.Result.SUCCESS
        BehaviourNode.Result.RUNNING:
            return BehaviourNode.Result.RUNNING
        _:
            return base

#endregion
