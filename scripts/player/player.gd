extends CharacterBody2D
class_name Player


const ROTATION_SPEED := 0.1
const SPEED := 300
const ACCELERATION := 5

var player_info : Dictionary

var desired_velocity := Vector2.ZERO
var desired_angle := 0.0
var mouse_angle := 0.0

@onready var body : Sprite2D = $Sprites/BodySprite
@onready var weapon_handler : WeaponHandler = $Sprites/WeaponHandler


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
		$Sprites/WeaponHandler/WeaponPivot/LeftHandSprite.texture = hands_texture
		$Sprites/WeaponHandler/WeaponPivot/RightHandSprite.texture = hands_texture
		
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
	desired_angle = lerp_angle(desired_angle, mouse_angle, ROTATION_SPEED)
	
	body.rotation = desired_angle
	weapon_handler.rotation = desired_angle
	
	move_and_slide()


func attacked(hand: String) -> void:
	print("Player attacked with hand ", hand)


func dropped_weapon(hand: String) -> void:
	print("Player dropped weapon in hand ", hand)


func picked_weapon(hand: String) -> void:
	print("Player picked up weapon with hand ", hand)
