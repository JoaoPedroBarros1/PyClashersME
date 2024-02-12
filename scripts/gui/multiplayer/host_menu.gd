extends Control


var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()


func _on_host_button_pressed() -> void:
	peer.create_server(8083, 3)
	multiplayer.multiplayer_peer = peer
	
	SceneTransition.change_scene.call_deferred(get_parent(), "gui/multiplayer/game_lobby.tscn")
