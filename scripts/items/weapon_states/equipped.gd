extends StateMachineState

# Called when the state machine enters this state.
func on_enter() -> void:
	state_machine.hitbox_component.monitoring = true
	state_machine.hitbox_component.set_collision_layer_value(5, false)
	state_machine.hitbox_component.set_collision_layer_value(3, true)


# Called every frame when this state is active.
func on_process(delta: float) -> void:
	pass


# Called every physics frame when this state is active.
func on_physics_process(delta: float) -> void:
	pass


# Called when there is an input event while this state is active.
func on_input(event: InputEvent) -> void:
	pass


# Called when the state machine exits this state.
func on_exit() -> void:
	pass

