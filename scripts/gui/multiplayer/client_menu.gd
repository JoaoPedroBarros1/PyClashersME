extends Control


var peer := ENetMultiplayerPeer.new()

@onready var nome_input : LineEdit = $VBoxContainer/NomeInput
@onready var ip_input : LineEdit = $VBoxContainer/IPInput
@onready var port_input : LineEdit = $VBoxContainer/PortInput


func _on_join_button_pressed() -> void:
	peer.create_client(ip_input.text, port_input.text.to_int())
	multiplayer.multiplayer_peer = peer
	
	queue_free()


func _on_back_button_pressed() -> void:
	SceneTransition.change_scene(get_parent(), "gui/multiplayer/multiplayer_menu.tscn")
