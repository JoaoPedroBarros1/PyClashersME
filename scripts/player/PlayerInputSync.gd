extends MultiplayerSynchronizer
class_name PlayerInput


@export var player : CharacterBody2D

@export var ability := false
@export var direction := Vector2.ZERO
@export var mouse_pos := Vector2.ZERO


@rpc("authority", "call_local", "reliable")
func use_ability() -> void:
	if ability:
		ability = false
		
	else:
		ability = true


func _ready() -> void:
	var is_authority : bool = get_multiplayer_authority() == multiplayer.get_unique_id()
	set_process(is_authority)
	set_process_input(is_authority)


func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("ability"):
		use_ability.rpc()


func _physics_process(delta: float) -> void:
	mouse_pos = player.get_global_mouse_position()
