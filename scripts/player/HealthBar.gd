extends ProgressBar


@export var health_component : HealthComponent


func _ready() -> void:
	max_value = health_component.MAX_HEALTH
	value = health_component.health
