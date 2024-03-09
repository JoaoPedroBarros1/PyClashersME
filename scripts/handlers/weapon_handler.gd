extends Node2D
class_name WeaponHandler

# enum PLAYER_ACTIONS {IDLE, ATTACK, DROP, PICKUP}

var ready_to_act : bool = true

@export var player : Player
@export var input : PlayerInput
@export var weapon_pickup_area : Area2D

@onready var weapon_pivot : Node2D = $WeaponPivot
@onready var weapon_offset : Node2D = $WeaponPivot/WeaponOffset
@onready var weapon_instance : Node2D = $WeaponPivot/WeaponOffset/WeaponInstance
var weapon : WeaponClass = null


var tween : Tween


func _ready() -> void:
	var is_authority : bool = get_multiplayer_authority() == multiplayer.get_unique_id()
	set_physics_process(is_authority)


func _physics_process(_delta: float) -> void:
	if not player.is_alive:
		return
	
	match input.player_action:
			input.PLAYER_ACTIONS.ATTACK:
				attack()
			
			input.PLAYER_ACTIONS.DROP:
				drop_weapon()
			
			input.PLAYER_ACTIONS.PICKUP:
				pick_weapon()
	
	input.player_action = input.PLAYER_ACTIONS.IDLE


func attack() -> void:	
	if not weapon:
		print("No weapon")
		return
	
	if not ready_to_act:
		print("Attack ain't ready")
		return
	ready_to_act = false
	
	tween = create_tween()
	
	tween_action(weapon.pre_attack_rotation, weapon.pre_attack_orientation, weapon.pre_attack_offset, weapon.pre_attack_transition, weapon.pre_attack_ease)
	tween.tween_callback(func() -> void: weapon.monitoring = true)
	tween_action(weapon.attack_rotation, weapon.attack_orientation, weapon.attack_offset, weapon.attack_transition, weapon.attack_ease)
	if not weapon.double_blade:
		tween.tween_callback(func() -> void: weapon.monitoring = false)
	tween_action(weapon.idle_rotation, weapon.idle_orientation, weapon.idle_offset, weapon.idle_transition, weapon.idle_ease)
	if weapon.double_blade:
		tween.tween_callback(func() -> void: weapon.monitoring = false)
	
	tween.tween_callback(func() -> void: ready_to_act = true)


func tween_action(weapon_rotation: int, weapon_orientation: int, weapon_offset_pos: int, weapon_transition : int, weapon_ease : int) -> void:
	tween.tween_property(weapon_pivot, "rotation_degrees", weapon_rotation, weapon.melee_weight).set_trans(weapon_transition).set_ease(weapon_ease)
	tween.parallel().tween_property(weapon_offset, "rotation_degrees", weapon_orientation, weapon.melee_weight).set_trans(weapon_transition).set_ease(weapon_ease)
	tween.parallel().tween_property(weapon_offset, "position", Vector2(weapon_offset_pos, 0), weapon.melee_weight).set_trans(weapon_transition).set_ease(weapon_ease)


func drop_weapon() -> void:
	if not weapon:
		return
	
	if not ready_to_act:
		return
	
	if not weapon.can_drop:
		print("Weapon not droppable")
		return
	
	print("Dropped weapon")
	weapon.weapon_holder = null
	weapon = null


func pick_weapon() -> void:
	if weapon:
		print("Already has weapon")
		return
	
	if not ready_to_act:
		return
	
	var overlapping_areas : Array[Area2D] = weapon_pickup_area.get_overlapping_areas()
	
	if overlapping_areas.is_empty():
		return
	
	overlapping_areas.sort_custom(get_closest_weapon_sort)
	
	print("Picked weapon")
	var picked_weapon : WeaponClass = overlapping_areas[0]
	
	weapon_instance.position = picked_weapon.primary_hand_pos.position
	weapon_instance.rotation = picked_weapon.primary_hand_pos.rotation
	
	picked_weapon.weapon_holder = self
	weapon = picked_weapon
	
	tween = create_tween()
	tween_action(weapon.idle_rotation, weapon.idle_orientation, weapon.idle_offset, weapon.idle_transition, weapon.idle_ease)
	


func get_closest_weapon_sort(a: Area2D, b: Area2D) -> bool:
	var a_distance : float = player.global_position.distance_squared_to(a.global_position)
	var b_distance : float = player.global_position.distance_squared_to(b.global_position)
	
	if a_distance < b_distance:
		return true
	
	return false
