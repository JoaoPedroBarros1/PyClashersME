extends Camera2D
class_name CameraHandler

@export var target : Player
@export var view_distance := 100


func _physics_process(_delta: float) -> void:
	if target:
		var mouse_distance : Vector2 = (target.input.mouse_pos - target.global_position).limit_length(view_distance)
		
		var camera_desired_position : Vector2 = target.global_position + mouse_distance
		global_position = lerp(global_position, camera_desired_position, 0.1)
