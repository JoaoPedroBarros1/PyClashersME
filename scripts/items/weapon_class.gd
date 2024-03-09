extends Area2D
class_name WeaponClass

@onready var primary_hand_pos : Marker2D = $PrimaryHandPos
@onready var secondary_hand_pos : Marker2D = $SecondaryHandPos


@export var double_blade : bool = false
@export var can_drop : bool = true
var weapon_holder : WeaponHandler = null

var can_attack := false

@export_group("Stances")

@export_subgroup("Pre-Attack Stance", "pre_attack_")
@export_range(-360, 360) var pre_attack_rotation : int = 50
@export_range(-360, 360) var pre_attack_orientation : int = 0
@export_range(30, 300) var pre_attack_offset : int = 30
@export var pre_attack_transition : Tween.TransitionType = Tween.TRANS_QUAD
@export var pre_attack_ease : Tween.EaseType = Tween.EASE_IN_OUT


@export_subgroup("Attack Stance", "attack_")
@export_range(-360, 360) var attack_rotation : int = -90
@export_range(-360, 360) var attack_orientation : int = -90
@export_range(30, 300) var attack_offset : int = 30
@export var attack_transition : Tween.TransitionType = Tween.TRANS_BACK
@export var attack_ease : Tween.EaseType = Tween.EASE_IN_OUT


@export_subgroup("Idle Stance", "idle_")
@export_range(-360, 360) var idle_rotation : int = 20
@export_range(-360, 360) var idle_orientation : int = 0
@export_range(30, 300) var idle_offset : int = 30
@export var idle_transition : Tween.TransitionType = Tween.TRANS_QUAD
@export var idle_ease : Tween.EaseType = Tween.EASE_IN_OUT


@export_group("Melee", "melee_")
@export_range(1, 100) var melee_damage : int = 50
@export_range(0.2, 1) var melee_weight : float = 0.5


func _process(_delta: float) -> void:
	if weapon_holder:
		global_position = weapon_holder.weapon_instance.global_position
		global_rotation = weapon_holder.weapon_instance.global_rotation


func _on_hitbox_area_entered(area: Area2D) -> void:
	if not area is HitboxComponent:
		return
	
	if weapon_holder.get_parent().get_parent() == area.get_parent():
		return
	
	var hitbox : HitboxComponent = area
	
	var attack := Attack.new()
	attack.attack_damage = melee_damage
	attack.weapon_weight = melee_weight
	attack.attack_position = $CollisionShape2D.global_position
	
	hitbox.damage(attack)
