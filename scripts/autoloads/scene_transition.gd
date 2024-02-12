extends CanvasLayer

@onready var animation_player : AnimationPlayer = $AnimationPlayer


func change_root_scene(target: String) -> void:
	print("Changing scene to ", "res://scenes/"+target)
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/"+target)
	animation_player.play_backwards("dissolve")


func change_scene(parent: Node, target: String) -> void:
	print("Changing scene to ", "res://scenes/"+target)
	animation_player.play("dissolve")
	await animation_player.animation_finished
	
	for child in parent.get_children():
		parent.remove_child(child)
		child.queue_free()
	
	var targetNode : PackedScene = load("res://scenes/"+target)
	print(targetNode)
	parent.add_child(targetNode.instantiate())
	
	animation_player.play_backwards("dissolve")
