extends Area2D

var ammo_type_event = 1


func _on_area_entered(area: Area2D) -> void:
	if area.name == 'player_hitbox':
		queue_free()
