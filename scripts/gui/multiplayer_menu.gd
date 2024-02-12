extends Control


func _client_btn_pressed() -> void:
	print("singleplayer_pressed")
	SceneTransition.change_scene(get_parent(), "gui/multiplayer/client_menu.tscn")


func _host_btn_pressed() -> void:
	print("multiplayer_pressed")
	SceneTransition.change_scene(get_parent(), "gui/multiplayer/host_menu.tscn")
