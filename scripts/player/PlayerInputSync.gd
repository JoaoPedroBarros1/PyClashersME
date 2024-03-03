extends MultiplayerSynchronizer
class_name PlayerInput

signal drop_weapon(hand: String)
signal pickup_weapon(hand: String)
signal attacked(hand: String)

@export var player : CharacterBody2D

@export var direction := Vector2.ZERO
@export var mouse_pos := Vector2.ZERO


func _ready() -> void:
	var is_authority : bool = get_multiplayer_authority() == multiplayer.get_unique_id()
	set_process(is_authority)
	set_physics_process(is_authority)


func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("left_click"):
		handle_mouse_input("left")
	
	if Input.is_action_just_pressed("right_click"):
		handle_mouse_input("right")


func _physics_process(_delta: float) -> void:
	mouse_pos = player.get_global_mouse_position()


func handle_mouse_input(mouse_pressed : String) -> void:
	if Input.is_action_pressed("drop"):
		drop_weapon.emit(mouse_pressed)
	
	elif Input.is_action_pressed("pickup"):
		pickup_weapon.emit(mouse_pressed)
	
	else:
		attacked.emit(mouse_pressed)
