## The base-class for composite-type behaviour nodes
class_name CompositeNode
extends BehaviourNode

var p_children: Array[BehaviourNode]


func _init(children: Array[BehaviourNode]) -> void:
    p_children = children


#region Events

func _on_behaviour_deinit() -> void:
    for child: BehaviourNode in p_children:
        if !is_instance_valid(child):
            continue

        child._on_behaviour_deinit()
        child.free()

#endregion