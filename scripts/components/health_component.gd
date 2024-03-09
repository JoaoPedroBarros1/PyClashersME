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
		health = 0
		died.emit(attack.attack_damage)
		player.is_alive = false
		
		if WEAPON_HANDLER.tween:
			WEAPON_HANDLER.tween.kill()
		
		WEAPON_HANDLER.drop_weapon()
		
		var tween : Tween = create_tween()
		
		tween.tween_property(player, "modulate:a", 0.5, 1)
	
	hurt.emit(attack.attack_damage)
