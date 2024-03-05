extends Node2D
class_name HealthComponent

signal hurt(damage: int)
signal died(damage: int)

@export var MAX_HEALTH : float = 100
var health : float

@onready var player : Player = get_parent()

func _ready() -> void:
	health = MAX_HEALTH


func damage(attack: Attack) -> void:
	print("Changed player velocity")
	var velocity : Vector2 = (player.global_position - attack.attack_position).normalized() * attack.weapon_weight * 1000
	print(velocity)
	player.velocity = velocity
	health -= attack.attack_damage
	
	hurt.emit(attack.attack_damage)
	if health <= 0:
		died.emit(attack.attack_damage)
