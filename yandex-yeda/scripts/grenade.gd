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
	$Timer2.start()
	$Sprite2D.texture = load("res://granata_sprite_expl.png")

func _on_timer_2_timeout() -> void:
	Eventbus.grenade_explosion.emit()
	Eventbus.grenade_explode.emit(15)
	queue_free()
