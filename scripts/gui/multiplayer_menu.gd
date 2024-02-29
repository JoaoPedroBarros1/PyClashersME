extends Control


func _client_btn_pressed() -> void:
	print("singleplayer_pressed")
	SceneTransition.change_root_scene("gui/multiplayer/client_menu.tscn")


func _host_btn_pressed() -> void:
	print("multiplayer_pressed")
	SceneTransition.change_root_scene("gui/multiplayer/host_menu.tscn")


func _on_back_button_pressed() -> void:
	SceneTransition.change_root_scene("gui/main_menu.tscn")
