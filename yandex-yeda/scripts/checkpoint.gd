extends Area2D




func _on_area_entered(area: Area2D) -> void:
	if area.name == 'player_hitbox':
		queue_free()
