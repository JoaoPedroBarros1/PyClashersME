extends Node2D


@onready var players : Node = $Players
var player_scene : PackedScene = preload("res://temporary/test_player.tscn")


func _ready() -> void:
	_add_player(1)
	
	print("Should only go for the server")
	print(multiplayer.get_peers())
	for peer in multiplayer.get_peers():
		typeof(peer)
		print("Peer:", peer)
		_add_player(peer)


func _add_player(id: int) -> void:
	var player : CharacterBody2D = player_scene.instantiate()
	player.name = str(id)
	players.call_deferred("add_child", player)
