extends Control


@export var player_scene : PackedScene
@onready var players_list := $HBoxContainer/PlayersList
@onready var button_label := $HBoxContainer


func _ready() -> void:
	if multiplayer.is_server():
		push_error("Server")
		var start_button := Button.new()
		start_button.text = "Começar jogo"
		start_button.pressed.connect(_start_game)
		button_label.add_child(start_button)
		button_label.move_child(start_button, 0)
		
		multiplayer.peer_connected.connect(_add_player)
		_add_player()
	
	else:
		push_error("Client")
		var client_label := Label.new()
		client_label.text = "Esperando host iniciar jogo"
		button_label.add_child(client_label)
		button_label.move_child(client_label, 0)


func _add_player(id := 1) -> void:
	var player := player_scene.instantiate()
	print("id:", id)
	player.name = str(id)
	players_list.call_deferred("add_child", player)


func _start_game() -> void:
	pass
