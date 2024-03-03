extends Node


const player_positions := [Vector2(17, 17), Vector2(17, 43), Vector2(53, 17), Vector2(53, 43)]
const map_start := Vector2(18, 18)
const map_end := Vector2(51, 41)

@onready var tile_map : TileMap = $TileMap
@onready var players : Node = $Players
@onready var weapons : Node = $Weapons

@export var camera_handler : CameraHandler
@export var weapons_list : Array[PackedScene]


func _ready() -> void:
	for weapon in weapons_list:
		$WeaponSpawner.add_spawnable_scene(weapon.resource_path)
	
	$PlayerSpawner.spawned.connect(update_player_camera)

	if not multiplayer.is_server():
		return

	for x in roundi((map_end.x - map_start.x) * 0.25):
		for y in roundi((map_end.y - map_start.y) * 0.25):
			var weapon_scene : PackedScene = weapons_list.pick_random()
			var loaded_weapon : WeaponClass = weapon_scene.instantiate()
			loaded_weapon.position = (Vector2(x, y) * 4 + map_start) * 64
			weapons.add_child(loaded_weapon, true)
	
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
