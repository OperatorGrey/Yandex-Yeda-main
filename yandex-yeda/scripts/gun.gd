extends Node2D

var num_bullets = 1

var ammo_type = 1

var gun_picked_up = false

var direction_left = false

var bullet_prefab = preload("res://bullet.tscn")
var bullet_prefab1 = preload("res://bullet1.tscn")

var ammo1
var ammo2



func _ready() -> void:
	Eventbus.gun_picked_up.connect(on_pick_up)

func on_pick_up():
	gun_picked_up = true

func _process(delta: float) -> void:
	Eventbus.shots_fired.emit(ammo1, ammo2)
	ammo1 = get_parent().ammo1
	ammo2 = get_parent().ammo2
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
		Eventbus.ammo_type_changed.emit(ammo_type)

func spawn_bullet(direction : Vector2):
		# Spawn a bullet
	$AudioStreamPlayer2D.play()
	var bullet
	if ammo_type == 1:
		if ammo1 > 0:
			bullet = bullet_prefab.instantiate()
			get_parent().ammo1 = ammo1 - 1
		else:
			return
	elif ammo_type == 2:
		if ammo2 > 0:
			bullet = bullet_prefab1.instantiate()
			get_parent().ammo2 = ammo2 - 1
		else:
			return
			
	if direction == Vector2.LEFT:
		bullet.position = global_position - Vector2(100,0)
		print('left')
	else:
		bullet.position = global_position + Vector2(100,0)
		print('right')
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
