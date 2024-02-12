extends CharacterBody2D


const SPEED = 300.0


func _enter_tree() -> void:
	print("Name:", name)
	set_multiplayer_authority(name.to_int())


func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		var move_vector : Vector2 = Input.get_vector("left", "right", "up", "down")
		if move_vector:
			velocity = move_vector * SPEED
		else:
			velocity = velocity.move_toward(move_vector, SPEED)

	move_and_slide()
