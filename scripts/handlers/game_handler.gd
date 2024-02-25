extends Node


@onready var players : Node = $Players
@export var camera_handler : CameraHandler


func _ready() -> void:
	$PlayerSpawner.spawned.connect(update_player_camera)
	
	if multiplayer.is_server():
		multiplayer.peer_connected.connect(add_player)
		multiplayer.peer_disconnected.connect(del_player)
	
		for peer in multiplayer.get_peers():
			add_player(peer)
		
		# Local (É o host)
		add_player(1)
		camera_handler.target = players.get_node("1")
		


func _exit_tree() -> void:
	if multiplayer.is_server():
		multiplayer.peer_connected.disconnect(add_player)
		multiplayer.peer_disconnected.disconnect(del_player)


func add_player(id: int) -> void:
	var character : CharacterBody2D = preload("res://scenes/player/player.tscn").instantiate()
	character.player = id
	character.position = Vector2(randi_range(-100, -100), randi_range(-100, 100))
	character.name = str(id)
	
	players.add_child(character)


func del_player(id: int) -> void:
	if players.has_node(str(id)):
		players.get_node(str(id)).queue_free()


func update_player_camera(player_added: CharacterBody2D) -> void:
	if multiplayer.get_unique_id() == player_added.name.to_int():
		camera_handler.target = player_added
