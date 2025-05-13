class_name BTUtils
extends Object


#region Functions

## Returns success if condition is true
static func b2r(condition: bool,
           fail_output := BTNode.FAIL) -> BTNode.Result:

    return BTNode.SUCCESS if condition else fail_output


## Inverts the value of [base]
static func invert(base: BTNode.Result) -> BTNode.Result:
    match base:
        BTNode.SUCCESS:
            return BTNode.FAIL
        BTNode.FAIL:
            return BTNode.SUCCESS
        BTNode.RUNNING:
            return BTNode.RUNNING
        _:
            return base

#endregion
