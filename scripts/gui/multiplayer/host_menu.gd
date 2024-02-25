extends Control


var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()

@onready var nome_input : LineEdit = $VBoxContainer/NomeInput
@onready var port_input : LineEdit = $VBoxContainer/PortInput


func _on_host_button_pressed() -> void:
	peer.create_server(port_input.text.to_int(), 3)
	multiplayer.multiplayer_peer = peer
	
	SceneTransition.change_scene(get_parent(), "gui/multiplayer/game_lobby.tscn")


func _on_back_button_pressed() -> void:
	SceneTransition.change_scene(get_parent(), "gui/multiplayer/multiplayer_menu.tscn")
