@icon("res://assets/img/icons/items/melee-icon.svg") 
class_name MeleeWeapon

extends Node2D

@export_enum("Hands", "Puncture", "Slash") var animation_type : int = 0

@export_group("Weapon Properties")
@export_enum("One Handed", "Two Handed") var weapon_type : int = 0
@export_enum("Both", "Left", "Right") var weapon_direction : int = 0

@export_subgroup("Weapon Numbers", "weapon_")
@export_range(1, 100) var weapon_damage : int = 50
@export_range(0, 1) var weapon_weight : float

@onready var animation_player := $AnimationPlayer
@onready var hitbox_component := $Node2D/HitboxComponent

@onready var hand_position_1 := $HandPosition1
@onready var hand_position_2 := $HandPosition2


func _ready() -> void:
	pass


func picked_up() -> void:
	hitbox_component.monitoring = true
