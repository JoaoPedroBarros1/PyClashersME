extends Node2D


@export var player_scene : PackedScene
@export var player_ui : PackedScene
var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()


func _on_join_button_pressed() -> void:
	peer.create_client("localhost", 8083)
	multiplayer.multiplayer_peer = peer


func _on_host_button_pressed() -> void:
	peer.create_server(8083, 3)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()


func _add_player(id := 1) -> void:
	var player := player_scene.instantiate()
	var ui_play := player_ui.instantiate()
	print("id:", id)
	player.name = str(id)
	ui_play.name = "ui_"+str(id)
	
	call_deferred("add_child", player)
	$VBoxContainer.call_deferred("add_child", ui_play)


func _on_fake_player_button_pressed() -> void:
	var ui_play := player_ui.instantiate()
	ui_play.name = str(randi_range(0, 1000))
	$VBoxContainer.call_deferred("add_child", ui_play)
