extends Control


func _singleplayer_btn_pressed() -> void:
	print("singleplayer_pressed")
	SceneTransition.change_root_scene.call_deferred("gui/singleplayer_menu.tscn")


func _multiplayer_btn_pressed() -> void:
	print("multiplayer_pressed")
	SceneTransition.change_root_scene.call_deferred("handlers/multiplayer_handler.tscn")
