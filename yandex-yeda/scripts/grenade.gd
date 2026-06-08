extends RigidBody2D

var throwing_direction_left = true


var is_on_floor: bool = false
#Physics checks
func throw_grenade(attack_left) -> void:
	throwing_direction_left = attack_left
	if throwing_direction_left == true:
		apply_impulse(Vector2(-500, 400)) 
	elif throwing_direction_left == false:
		apply_impulse(Vector2(500, 400))
	$Timer.start()

func _on_timer_timeout() -> void:
	Eventbus.grenade_explosion.emit()
	queue_free()
