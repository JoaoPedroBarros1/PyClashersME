extends Control


@onready var nome_input : LineEdit = $VBoxContainer/NomeInput
@onready var port_input : LineEdit = $VBoxContainer/PortInput


func _on_host_button_pressed() -> void:
	MultiplayerHandler.local_player_info["name"] = nome_input.text
	MultiplayerHandler.host_server()


func _on_back_button_pressed() -> void:
	SceneTransition.change_root_scene("gui/multiplayer/multiplayer_menu.tscn")
