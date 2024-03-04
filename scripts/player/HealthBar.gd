extends ProgressBar


@export var health_component : HealthComponent


func _ready() -> void:
	health_component.hurt.connect(func(_damage: int) -> void: value = health_component.health)
	max_value = health_component.MAX_HEALTH
	value = health_component.health
