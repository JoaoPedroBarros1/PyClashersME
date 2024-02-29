extends Control


@onready var nome_input : LineEdit = $VBoxContainer/NomeInput
@onready var ip_input : LineEdit = $VBoxContainer/IPInput
@onready var port_input : LineEdit = $VBoxContainer/PortInput


func _on_join_button_pressed() -> void:
	MultiplayerHandler.local_player_info["name"] = nome_input.text
	MultiplayerHandler.join_server()


func _on_back_button_pressed() -> void:
	SceneTransition.change_root_scene("gui/multiplayer/multiplayer_menu.tscn")
