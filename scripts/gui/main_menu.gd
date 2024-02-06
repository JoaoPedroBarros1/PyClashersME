extends Control


func _ready() -> void:
	$VBoxContainer/SingleplayerButton.connect("toggled", singleplayer_btn_pressed)
	$VBoxContainer/MultiplayerButton.connect("toggled", multiplayer_btn_pressed)


func _process(delta: float) -> void:
	pass


func singleplayer_btn_pressed() -> void:
	print("singleplayer_pressed")


func multiplayer_btn_pressed() -> void:
	print("multiplayer_pressed")
