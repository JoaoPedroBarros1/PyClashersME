extends CharacterBody2D
class_name Player


const BODY_ROTATION_SPEED := 0.1
const HAND_ROTATION_SPEED := 0.2


const SPEED := 300
const ACCELERATION := 5

var desired_velocity := Vector2.ZERO
var mouse_angle : float

@onready var body : Sprite2D = $BodySprite
@onready var left_hand : Sprite2D = $LeftHandSprite
@onready var right_hand : Sprite2D = $RightHandSprite


@onready var input : PlayerInput = $PlayerInputSync


@export var player := 1 :
	set(id):
		player = id
		$PlayerInputSync.set_multiplayer_authority(id)


func _physics_process(delta: float) -> void:
	if input.ability:
		$AbilityLabel.visible = true
		
	else:
		$AbilityLabel.visible = false
	
	if input.direction:
		desired_velocity = input.direction * SPEED
	else:
		desired_velocity = Vector2.ZERO
	
	velocity = velocity.move_toward(desired_velocity, ACCELERATION * SPEED * delta)
	
	mouse_angle = (input.mouse_pos - body.global_position).angle()
	body.global_rotation = lerp_angle(body.global_rotation, mouse_angle, BODY_ROTATION_SPEED)
	
	var left_hand_rotation : float = lerp_angle(left_hand.rotation, body.global_rotation, HAND_ROTATION_SPEED)
	left_hand.rotation = left_hand_rotation
	
	var right_hand_rotation : float = lerp_angle(right_hand.rotation, body.global_rotation, HAND_ROTATION_SPEED)
	right_hand.rotation = right_hand_rotation
	
	move_and_slide()
