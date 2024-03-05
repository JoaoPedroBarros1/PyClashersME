extends Area2D
class_name WeaponClass


@export var can_drop : bool = true
@onready var weapon_origin : Node = get_parent()
var weapon_holder : Player = null

var is_weapon_dropped := true
var can_attack := false

@export_group("Stances")

@export_subgroup("Pre-Attack Stance", "pre_attack_")
@export_range(-180, 180) var pre_attack_rotation : int = 50
@export_range(-90, 90) var pre_attack_orientation : int = 0
@export_range(30, 300) var pre_attack_offset : int = 30
@export var pre_attack_transition : Tween.TransitionType = Tween.TRANS_QUAD
@export var pre_attack_ease : Tween.EaseType = Tween.EASE_IN_OUT

@export_subgroup("Attack Stance", "attack_")
@export_range(-180, 180) var attack_rotation : int = -90
@export_range(-90, 90) var attack_orientation : int = -90
@export_range(30, 300) var attack_offset : int = 30
@export var attack_transition : Tween.TransitionType = Tween.TRANS_BACK
@export var attack_ease : Tween.EaseType = Tween.EASE_IN_OUT


@export_subgroup("Idle Stance", "idle_")
@export_range(-180, 180) var idle_rotation : int = 20
@export_range(-90, 90) var idle_orientation : int = 0
@export_range(30, 300) var idle_offset : int = 30
@export var idle_transition : Tween.TransitionType = Tween.TRANS_QUAD
@export var idle_ease : Tween.EaseType = Tween.EASE_IN_OUT


@export_group("Melee", "melee_")
@export_enum("Hands", "One Handed", "Two Handed") var melee_type : int = 1
@export_range(1, 100) var melee_damage : int = 50
@export_range(0.2, 1) var melee_weight : float = 0.5


func _on_hitbox_area_entered(area: Area2D) -> void:
	if not area is HitboxComponent:
		return
	var shape_owner := shape_owner_get_owner(get_shape_owners()[0])
	if shape_owner != area.get_parent():
		return
	
	var hitbox : HitboxComponent = area
	
	var attack := Attack.new()
	attack.attack_damage = melee_damage
	attack.weapon_weight = melee_weight
	attack.attack_position = $CollisionShape2D.global_position
	
	hitbox.damage(attack)
