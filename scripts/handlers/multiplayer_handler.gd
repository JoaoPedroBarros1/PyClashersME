extends Node


func _exit_tree() -> void:
	if multiplayer.has_multiplayer_peer():
		print("Closing multiplayer")
		multiplayer.multiplayer_peer = null
