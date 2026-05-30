extends CharacterBody2D


var hitpoints = 5


func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "bullet":
		if hitpoints > 0:
			hitpoints = hitpoints - 1
		else:
			hitpoints = 5
			queue_free()
	elif area.name == "bullet1":
		if hitpoints > 0:
			hitpoints = hitpoints - 2
			Eventbus.enemy_stun_start.emit()
			$'stun_timer'.start()
	else:
		queue_free()
	if area.name == "player_hitbox":
		$'attack_timer'.start()
		Eventbus.attack_animation_start.emit()
		

func _on_timer_timeout() -> void:
	Eventbus.attack_animation_end.emit()


func _on_stun_timer_timeout() -> void:
	Eventbus.enemy_stun_stop.emit()
