extends Camera2D


var target : Node2D :
	set(target):
		global_position = target.global_position


func _physics_process(delta: float) -> void:
	global_position = global_position.lerp(target.global_position, 0.2)
