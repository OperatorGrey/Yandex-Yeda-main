extends CharacterBody2D





func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "bullet":
		queue_free()
