extends RigidBody2D

var throwing_direction_right = true

var is_on_floor: bool = false
#Physics checks
func _ready() -> void:
	if throwing_direction_right == true:
		apply_impulse(Vector2(200, 0)) 
	elif throwing_direction_right == false:
		apply_impulse(Vector2(-200, 0))
func _on_grenade_physics_area_entered(area: Area2D) -> void:
	is_on_floor = true
func _on_grenade_physics_area_exited(area: Area2D) -> void:
	is_on_floor = false

func _process(delta: float) -> void:
	if is_on_floor == true:
		$Timer.start()
		
func _on_timer_timeout() -> void:
	Eventbus.grenade_explosion.emit()
	queue_free()
