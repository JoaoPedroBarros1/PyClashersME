extends Control


@export var player_scene : PackedScene
@onready var players_list := $HBoxContainer/PlayersList
@onready var button_label := $HBoxContainer/GameSettings


func _ready() -> void:
	if multiplayer.is_server():
		var start_button := Button.new()
		start_button.text = "Começar jogo"
		start_button.pressed.connect(_start_game)
		button_label.add_child(start_button)
		button_label.move_child(start_button, 0)
		
		MultiplayerHandler.player_connected.connect(add_player)
		MultiplayerHandler.player_disconnected.connect(del_player)
		add_player(1, MultiplayerHandler.players[1])
	
	else:
		var client_label := Label.new()
		client_label.text = "Esperando host iniciar jogo"
		button_label.add_child(client_label)
		button_label.move_child(client_label, 0)


func add_player(id: int, player_info: Dictionary) -> void:
	print("Player added with id: ", id)
	var player : Player = player_scene.instantiate()
	player.name = str(id)
	player.player_info = player_info.duplicate(true)
	players_list.call_deferred("add_child", player)


func del_player(id: int) -> void:
	if players_list.has_node(str(id)):
		players_list.get_node(str(id)).queue_free()


func _start_game() -> void:
	MultiplayerHandler.load_game.rpc("handlers/game_handler.tscn")


func _on_back_button_pressed() -> void:
	MultiplayerHandler.remove_multiplayer_peer()
	SceneTransition.change_root_scene("gui/main_menu.tscn")
