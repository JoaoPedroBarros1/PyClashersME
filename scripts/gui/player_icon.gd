extends HBoxContainer


@onready var label : Label = $Label


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _ready() -> void:
	label.text = name
