extends ProgressBar


@export var MAX_HEALTH : int = 100
var health : int


func _ready() -> void:
	health = MAX_HEALTH
	
	max_value = MAX_HEALTH
	value = health
