extends Node2D

var num_bullets = 1

var gun_picked_up = false

var direction_left = false

var bullet_prefab = preload("res://bullet.tscn")

func _ready() -> void:
	Eventbus.gun_picked_up.connect(on_pick_up)

func on_pick_up():
	gun_picked_up = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		if gun_picked_up == true:
			shoot()
	if Input.is_action_just_pressed("ui_left"):
		direction_left = true
	if Input.is_action_just_pressed("ui_right"):
		direction_left = false
	

func spawn_bullet(direction : Vector2):
		# Spawn a bullet
	var bullet = bullet_prefab.instantiate()
	bullet.position = global_position
	bullet.direction = direction 
	get_tree().root.add_child(bullet)

func shoot():
	var direction
	if direction_left == true:
		direction = Vector2.LEFT
	elif direction_left == false:
		direction = Vector2.RIGHT
	var step = 2*PI / num_bullets
	for i in range(num_bullets):
		spawn_bullet(direction)
		#rotate direction
		direction = direction.rotated(step)
