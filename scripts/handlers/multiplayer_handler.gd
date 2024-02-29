extends Node


signal player_connected(peer_id: int, player_info: Dictionary)
signal player_disconnected(peer_id: int)
signal server_disconnected


const PORT = 7000
const DEFAULT_SERVER_IP = "127.0.0.1"
const MAX_CONNECTIONS = 3


var local_player_info := {"name": "PlayerName"}
var players : Dictionary = {}
var players_loaded : int = 0


func _ready() -> void:
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


func join_server(address := "") -> void:
	if address.is_empty():
		address = DEFAULT_SERVER_IP
		
	var peer := ENetMultiplayerPeer.new()
	var error := peer.create_client(address, PORT)
	
	if error:
		printerr(error)
		return
	
	multiplayer.multiplayer_peer = peer
	SceneTransition.change_root_scene("gui/multiplayer/game_lobby.tscn")


func host_server() -> void:
	print("Hosting")
	var peer := ENetMultiplayerPeer.new()
	var error := peer.create_server(PORT, MAX_CONNECTIONS)
	
	if error:
		printerr(error)
		return
	
	multiplayer.multiplayer_peer = peer
	
	players[1] = local_player_info
	
	SceneTransition.change_root_scene("gui/multiplayer/game_lobby.tscn")
	
	player_connected.emit(1, local_player_info)


func remove_multiplayer_peer() -> void:
	multiplayer.multiplayer_peer = null


func _on_player_connected(id: int) -> void:
	_register_player.rpc_id(id, local_player_info)


func _on_player_disconnected(id: int) -> void:
	players.erase(id)
	player_disconnected.emit(id)


func _on_connected_ok() -> void:
	var peer_id : int = multiplayer.get_unique_id()
	players[peer_id] = local_player_info
	player_connected.emit(peer_id, local_player_info)


func _on_connected_fail() -> void:
	multiplayer.multiplayer_peer = null


func _on_server_disconnected() -> void:
	print("Closing multiplayer")
	get_tree().change_scene_to_file("res://scenes/gui/main_menu.tscn")
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()





@rpc("any_peer", "reliable")
func _register_player(new_player_info: Dictionary) -> void:
	var new_player_id : int = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	player_connected.emit(new_player_id, new_player_info)


@rpc("call_local", "reliable")
func load_game(game_scene_path: NodePath) -> void:
	SceneTransition.change_root_scene(game_scene_path)


# Every peer will call this when they have loaded the game scene.
@rpc("any_peer", "call_local", "reliable")
func player_loaded() -> void:
	if multiplayer.is_server():
		players_loaded += 1
		if players_loaded == players.size():
			$/root/GameHandler.start_game()
			players_loaded = 0
