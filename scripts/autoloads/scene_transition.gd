extends CanvasLayer

@onready var animation_player : AnimationPlayer = $AnimationPlayer


func change_root_scene(target: String, block_input: bool = false) -> void:
	_change_root_scene.call_deferred(target, block_input)


func change_scene(parent: Node, target: String, block_input: bool = false) -> void:
	_change_scene.call_deferred(parent, target, block_input)


func _change_root_scene(target: String, block_input: bool) -> void:
	if block_input:
		$ColorRect.mouse_filter = Control.MOUSE_FILTER_STOP
		animation_player.animation_finished.connect(_block_mouse_input)
	
	print("Changing scene to ", "res://scenes/"+target)
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/"+target)
	animation_player.play_backwards("dissolve")


func _change_scene(parent: Node, target: String, block_input: bool) -> void:
	if block_input:
		$ColorRect.mouse_filter = Control.MOUSE_FILTER_STOP
		animation_player.animation_finished.connect(_block_mouse_input)
	
	print("Changing scene to ", "res://scenes/"+target)
	animation_player.play("dissolve")
	await animation_player.animation_finished
	
	for child in parent.get_children():
		parent.remove_child(child)
		child.queue_free()
	
	var targetNode : PackedScene = load("res://scenes/"+target)
	parent.add_child(targetNode.instantiate())
	
	animation_player.play_backwards("dissolve")


func _block_mouse_input() -> void:
	animation_player.animation_finished.disconnect(_block_mouse_input)
	$ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
