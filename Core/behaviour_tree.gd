## An AI agent evaluator that uses behaviour nodes for action processing
class_name BehaviourTree
extends RefCounted

## When used in a context dictionary, it returns a pointer to owner of the behaviour tree
const BTK_TREE_OWNER := &"t_owner"

var p_root: BehaviourNode
var p_context: Dictionary[StringName, Variant]

var m_sleep_ticks := 0.0


func _init(owner: Node, root: BehaviourNode) -> void:
    p_root = root
    p_context = { BTK_TREE_OWNER = owner }


#region Utils

## Updates the owner reference
func set_owner(owner: Node) -> void:
    p_context[BTK_TREE_OWNER] = owner


## Forces the tree to wake up
func wake() -> void:
    m_sleep_ticks = 0.0


## Sets the tree to sleep for a specified period of time
func sleep(duration: float) -> void:
    m_sleep_ticks = duration


## Processes the tree when it's awake
func process(delta: float) -> void:
    if m_sleep_ticks > 0.0:
        m_sleep_ticks -= delta
        return

    p_root._on_behaviour_process(p_context)


## Forces the evaluation of the tree regardless of its wake status
func force_process() -> void:
    p_root._on_behaviour_process(p_context)

#endregion


#region Events

func _notification(what: int) -> void:
    # This ensures that all behaviour nodes are cleaned up properly
    if (what != NOTIFICATION_PREDELETE ||
        !is_instance_valid(p_root)):
        return

    p_root._on_behaviour_deinit()
    p_root.free()

#endregion