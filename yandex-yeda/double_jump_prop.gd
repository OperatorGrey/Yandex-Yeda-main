extends Area2D




func _on_area_entered(area: Area2D) -> void:
	if area.name == 'player_hitbox':
		Eventbus.jumpboots_picked_up.emit()
		queue_free()
