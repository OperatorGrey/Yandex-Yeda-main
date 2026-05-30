extends Node2D

var num_bullets = 1

var ammo_type = 1

var gun_picked_up = false

var direction_left = false

var bullet_prefab = preload("res://bullet.tscn")
var bullet_prefab1 = preload("res://bullet1.tscn")

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
	if Input.is_action_just_pressed("ammo_type_change"):
		if ammo_type == 1:
			ammo_type = 2
		else:
			ammo_type = 1

func spawn_bullet(direction : Vector2):
		# Spawn a bullet
	var bullet
	if ammo_type == 1:
		bullet = bullet_prefab.instantiate()
	elif ammo_type == 2:
		bullet = bullet_prefab1.instantiate()
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
