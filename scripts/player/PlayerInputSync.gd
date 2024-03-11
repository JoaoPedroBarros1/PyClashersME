extends MultiplayerSynchronizer
class_name PlayerInput


enum PLAYER_ACTIONS {IDLE, ATTACK, DROP, PICKUP}
@export var player : CharacterBody2D

var direction := Vector2.ZERO
var mouse_pos := Vector2.ZERO
var player_action : PLAYER_ACTIONS = PLAYER_ACTIONS.IDLE


func _ready() -> void:
	var is_authority : bool = get_multiplayer_authority() == multiplayer.get_unique_id()
	set_process(is_authority)
	set_physics_process(is_authority)


func _process(_delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("click"):
		if Input.is_action_pressed("drop"):
			take_action.rpc(PLAYER_ACTIONS.DROP)
	
		elif Input.is_action_pressed("pickup"):
			take_action.rpc(PLAYER_ACTIONS.PICKUP)
		
		else:
			take_action.rpc(PLAYER_ACTIONS.ATTACK)
		


func _physics_process(_delta: float) -> void:
	mouse_pos = player.get_global_mouse_position()


@rpc("authority", "call_local", "reliable")
func take_action(action: PLAYER_ACTIONS) -> void:
	player_action = action
