extends Node2D
class_name HealthComponent

signal hurt(damage: int)
signal died(damage: int)

@export var WEAPON_HANDLER : WeaponHandler
@export var MAX_HEALTH : float = 100
var health : float

@onready var player : Player = get_parent()

func _ready() -> void:
	health = MAX_HEALTH


func damage(attack: Attack) -> void:
	var velocity : Vector2 = (player.global_position - attack.attack_position).normalized() * attack.weapon_weight * 1100
	player.velocity = velocity
	
	health -= attack.attack_damage
	
	if health <= 0:
		died.emit(attack.attack_damage)
		#if WEAPON_HANDLER.weapon:
			#WEAPON_HANDLER.drop_weapon()
		return
	
	hurt.emit(attack.attack_damage)
