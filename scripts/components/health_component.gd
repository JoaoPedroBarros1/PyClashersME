extends Node2D
class_name HealthComponent

signal hurt(damage: int)
signal died(damage: int)

@export var MAX_HEALTH : float = 100
var health : float

func _ready() -> void:
	health = MAX_HEALTH


func damage(attack: Attack) -> void:
	health -= attack.attack_damage
	
	if health <= 0:
		died.emit(attack.attack_damage)
		get_parent().queue_free()
	else:
		hurt.emit(attack.attack_damage)
