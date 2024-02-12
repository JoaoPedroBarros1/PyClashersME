extends Control


var peer := ENetMultiplayerPeer.new()

@onready var NameInput : LineEdit = $VBoxContainer/NomeInput
@onready var IPInput : LineEdit = $VBoxContainer/IPInput
@onready var PortInput : LineEdit = $VBoxContainer/PortInput


func _on_join_button_pressed() -> void:
	peer.create_client("localhost", 8083)
	multiplayer.multiplayer_peer = peer
	
	queue_free()
