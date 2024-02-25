extends Area2D
class_name HitboxComponent


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Defensive"):
		print("Clashed with shield")
	
	elif area.is_in_group("Sword"):
		print("Clashed with sword")
