extends Node2D

var num_bullets = 1

var bullet_prefab = preload("res://bullet.tscn")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		shoot()
	

func spawn_bullet(direction : Vector2):
		# Spawn a bullet
	var bullet = bullet_prefab.instantiate()
	bullet.position = global_position
	bullet.direction = direction 
	get_tree().root.add_child(bullet)

func shoot():
	var direction = Vector2.RIGHT
	var step = 2*PI / num_bullets
	for i in range(num_bullets):
		spawn_bullet(direction)
		#rotate direction
		direction = direction.rotated(step)
