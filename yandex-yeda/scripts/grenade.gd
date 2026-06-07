extends RigidBody2D

var throwing_direction_right = true

var is_on_floor: bool = false
#Physics checks
func _ready() -> void:
	if throwing_direction_right == true:
		apply_impulse(Vector2(1000, 400)) 
	elif throwing_direction_right == false:
		apply_impulse(Vector2(1000, 400))
	$Timer.start()
func _on_timer_timeout() -> void:
	Eventbus.grenade_explosion.emit()
	queue_free()
