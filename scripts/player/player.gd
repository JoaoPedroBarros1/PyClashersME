extends CharacterBody2D
class_name Player


const BODY_ROTATION_SPEED := 0.1
const HAND_ROTATION_SPEED := 0.2


const SPEED := 300
const ACCELERATION := 5

var desired_velocity := Vector2.ZERO
var mouse_angle : float

@onready var body : Sprite2D = $Sprites/BodySprite
@onready var left_hand : Sprite2D = $Sprites/LeftHandSprite
@onready var right_hand : Sprite2D = $Sprites/RightHandSprite


@onready var input : PlayerInput = $PlayerInputSync


@export var player := 1 :
	set(id):
		player = id
		$PlayerInputSync.set_multiplayer_authority(id)


var colors_list := ["green", "purple", "red", "yellow"]
@export_enum("green", "purple", "red", "yellow") var player_color := 0 :
	set(color):
		player_color = color
		var sprite_color : String = colors_list[color]
	
		var hand_path : String = "res://assets/img/characters/hand/"+sprite_color+"_hand.png"
		var hands_texture : CompressedTexture2D = load(hand_path)
		$Sprites/LeftHandSprite.texture = hands_texture
		$Sprites/RightHandSprite.texture = hands_texture
		
		var body_path : String = "res://assets/img/characters/body/"+sprite_color+"_body.png"
		var body_texture : CompressedTexture2D = load(body_path)
		$Sprites/BodySprite.texture = body_texture


func _physics_process(delta: float) -> void:
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
