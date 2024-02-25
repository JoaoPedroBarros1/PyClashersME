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
		
		multiplayer.peer_connected.connect(add_player)
		multiplayer.peer_disconnected.connect(del_player)
		add_player(1)
	
	else:
		var client_label := Label.new()
		client_label.text = "Esperando host iniciar jogo"
		button_label.add_child(client_label)
		button_label.move_child(client_label, 0)


func add_player(id: int) -> void:
	print("Player added")
	var player := player_scene.instantiate()
	print("id:", id)
	player.name = str(id)
	players_list.call_deferred("add_child", player)


func del_player(id: int) -> void:
	if players_list.has_node(str(id)):
		players_list.get_node(str(id)).queue_free()


func _start_game() -> void:
	SceneTransition.change_scene(get_parent(), "handlers/game_handler.tscn")


func _on_back_button_pressed() -> void:
	SceneTransition.change_root_scene("gui/main_menu.tscn")
