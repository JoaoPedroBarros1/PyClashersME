extends Node


const player_positions := [Vector2(17, 17), Vector2(17, 43), Vector2(53, 17), Vector2(53, 43)]


@onready var players : Node = $Players
@export var camera_handler : CameraHandler


func _ready() -> void:
	$PlayerSpawner.spawned.connect(update_player_camera)
	
	if multiplayer.is_server():
		multiplayer.peer_disconnected.connect(del_player)
		
		var multiplayer_peers := multiplayer.get_peers()
		for peer_index in multiplayer_peers.size():
			var peer := multiplayer_peers[peer_index]
			add_player(peer, peer_index + 1)
		
		# Local (É o host)
		add_player(1, 0)
		camera_handler.target = players.get_node("1")


func add_player(id: int, index: int) -> void:
	var character : CharacterBody2D = preload("res://scenes/player/player.tscn").instantiate()
	character.player = id
	character.position = player_positions[index] * 64
	character.name = str(id)
	character.player_color = index
	
	players.add_child(character)


func del_player(id: int) -> void:
	if players.has_node(str(id)):
		players.get_node(str(id)).queue_free()


func update_player_camera(player_added: CharacterBody2D) -> void:
	if multiplayer.get_unique_id() == player_added.name.to_int():
		camera_handler.target = player_added
