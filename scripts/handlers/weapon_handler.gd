extends Node2D
class_name WeaponHandler

var attack_ready : bool = true

@export var player : Player
@export var input : PlayerInput
@export var weapon_pickup_area : Area2D

@onready var weapon_pivot : Node2D = $WeaponPivot
@onready var weapon_offset : Node2D = $WeaponPivot/WeaponOffset
@export var weapon : WeaponClass
# @onready var right_hand_sprite : Sprite2D = $WeaponPivot/RightHandSprite
# @onready var left_hand_sprite : Sprite2D = $WeaponPivot/LeftHandSprite


func _ready() -> void:
	input.attacked.connect(attack)
	input.drop_weapon.connect(drop_weapon)
	input.pickup_weapon.connect(pick_weapon)


func attack(_hand: String) -> void:	
	if not weapon:
		print("No weapon")
		return
	
	if not attack_ready:
		print("Attack ain't ready")
		return
	attack_ready = false
	
	var tween : Tween = create_tween()
	
	# Pre-Attack
	tween_action(tween, weapon.pre_attack_rotation, weapon.pre_attack_orientation, weapon.pre_attack_transition, weapon.pre_attack_ease)
	
	# Attack
	tween_action(tween, weapon.attack_rotation, weapon.attack_orientation, weapon.attack_transition, weapon.attack_ease)
	
	# Idle
	tween_action(tween, weapon.idle_rotation, weapon.idle_orientation, weapon.idle_transition, weapon.idle_ease)
	
	tween.tween_callback(func() -> void: attack_ready = true)


func tween_action(tween : Tween, weapon_rotation : int, weapon_orientation : int, weapon_transition : int, weapon_ease : int) -> void:
	tween.tween_property(weapon_pivot, "rotation_degrees", weapon_rotation, weapon.melee_weight).set_trans(weapon_transition).set_ease(weapon_ease)
	tween.parallel().tween_property(weapon_offset, "rotation_degrees", weapon_orientation, weapon.melee_weight).set_trans(weapon_transition).set_ease(weapon_ease)


func drop_weapon(_hand: String) -> void:
	if not attack_ready:
		return
	
	if weapon.can_drop:
		print("Dropped weapon")
	else:
		print("Weapon not droppable")


func pick_weapon(_hand: String) -> void:
	if not attack_ready:
		return
	
	var overlapping_areas : Array[Area2D] = weapon_pickup_area.get_overlapping_areas()
	overlapping_areas.sort_custom(get_closest_weapon_sort)
	
	if weapon:
		print("Already used")
		return
	print("Picked weapon")
	weapon_offset = weapon.get_parent()
	weapon_pivot = weapon_offset.get_parent()


func get_closest_weapon_sort(a: Area2D, b: Area2D) -> bool:
	var a_distance : float = player.global_position.distance_squared_to(a.global_position)
	var b_distance : float = player.global_position.distance_squared_to(b.global_position)
	
	if a_distance < b_distance:
		return true
	
	return false
