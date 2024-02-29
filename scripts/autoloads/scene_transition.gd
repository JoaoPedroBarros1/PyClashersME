extends CanvasLayer

@onready var animation_player : AnimationPlayer = $AnimationPlayer


func change_root_scene(target: String, block_input: bool = true) -> void:
	_change_root_scene.call_deferred(target, block_input)


func _change_root_scene(target: String, block_input: bool) -> void:
	if block_input:
		$ColorRect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	print("Changing scene to ", "res://scenes/"+target)
	animation_player.play("dissolve")
	
	await animation_player.animation_finished
	$ColorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	get_tree().change_scene_to_file("res://scenes/"+target)
	animation_player.play_backwards("dissolve")
