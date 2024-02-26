extends Node2D
class_name WeaponClass

@export_enum("Melee", "Ranged", "Shield") var weapon_type : int = 0


@export_group("Melee")
@export_enum("One Handed", "Two Handed") var melee_type : int = 0
@export_enum("Both", "Left", "Right") var melee_direction : int = 0
@export_range(1, 100) var melee_damage : int = 50
@export_range(0.2, 1) var melee_weight : float = 0.5
@export_enum("Stab", "Slash") var melee_animations : int = 0

@export_group("Ranged")
@export_range(1, 100) var ranged_damage : int = 50
@export_range(0.2, 1) var ranged_weight : float = 0.5
@export var ranged_projectile : PackedScene

@export_group("Shield")
@export_range(0.2, 1) var shield_weight : float


func _ready() -> void:
	print(melee_animations)