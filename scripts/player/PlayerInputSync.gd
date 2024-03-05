extends MultiplayerSynchronizer
class_name PlayerInput


enum PLAYER_ACTIONS {ATTACK, DROP, PICKUP}
@export var player : CharacterBody2D
@export var weapon_handler : WeaponHandler

@export var direction := Vector2.ZERO
@export var mouse_pos := Vector2.ZERO


func _ready() -> void:
	var is_authority : bool = get_multiplayer_authority() == multiplayer.get_unique_id()
	set_process(is_authority)
	set_physics_process(is_authority)


func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("click"):
		var player_input : PLAYER_ACTIONS = PLAYER_ACTIONS.ATTACK
		
		if Input.is_action_pressed("drop"):
			player_input = PLAYER_ACTIONS.DROP
	
		elif Input.is_action_pressed("pickup"):
			player_input = PLAYER_ACTIONS.PICKUP
		
		handle_mouse_input.rpc(player_input)


func _physics_process(_delta: float) -> void:
	mouse_pos = player.get_global_mouse_position()


@rpc("call_local", "reliable")
func handle_mouse_input(player_input : PLAYER_ACTIONS) -> void:
	match player_input:
		PLAYER_ACTIONS.DROP:
			weapon_handler.drop_weapon()
		
		PLAYER_ACTIONS.PICKUP:
			weapon_handler.pick_weapon()
		
		_:
			weapon_handler.attack()
