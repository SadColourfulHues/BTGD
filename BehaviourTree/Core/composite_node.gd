## The base-class for composite-type behaviour nodes
class_name CompositeNode
extends BTNode

var p_children: Array[BTNode]


func _init(children: Array[BTNode]) -> void:
    p_children = children


#region Events

func _on_behaviour_deinit() -> void:
    for child: BTNode in p_children:
        if !is_instance_valid(child):
            continue

        child._on_behaviour_deinit()
        child.free()

#endregion
