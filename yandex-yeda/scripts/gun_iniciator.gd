extends Area2D




func _on_area_entered(area: Area2D) -> void:
	Eventbus.gun_picked_up.emit()
	queue_free()
