extends CharacterBody2D





func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "bullet":
		queue_free()
	if area.name == "player_hitbox":
		$'Timer'.start()
		Eventbus.attack_animation_start.emit()

func _on_timer_timeout() -> void:
	Eventbus.attack_animation_end.emit()
