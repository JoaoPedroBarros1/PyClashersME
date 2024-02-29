extends HBoxContainer

@onready var player_name := $PlayerName


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())


func _ready() -> void:
	player_name.text = MultiplayerHandler.players[name.to_int()]["name"]
