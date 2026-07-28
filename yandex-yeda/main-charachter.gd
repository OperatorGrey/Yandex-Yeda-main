extends CharacterBody2D

var start_pos = Vector2 (142.0, 448.0)
var SPEED = 0.0
var JUMP_VELOCITY = -400.0
var hp = 3
var double_jump = false
var jump_counter = 0
var ammo1 = 1
var ammo2 = 1


func _ready() -> void:
	Eventbus.attack_animation_end.connect(_hitcheck)
	Eventbus.player_hit.connect(_on_hit)
	Eventbus.grenade_explosion.connect(_grenade_hitcheck)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		jump_counter = 0

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
				velocity.y = JUMP_VELOCITY
				jump_counter = 1
		else:
			if double_jump == true:
				if jump_counter == 1:
					velocity.y = JUMP_VELOCITY
					jump_counter = 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
		#flip_h on left
	if Input.is_action_pressed("ui_left"):
		SPEED = 400
		velocity.x = direction * SPEED
	elif Input.is_action_pressed("ui_right"):
		SPEED = 400
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
func respawn(): 
	velocity.x = 0
	
	position = start_pos




func _on_hit(new_hp) -> void:
	if hp >= 1:
		hp = hp - 1
	else:
		hp = 3
		respawn()
	print(r'{hp}')
	move_and_slide()


func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if  area.name == 'checkpoint':
		start_pos = area.position
		Eventbus.checkpoint_reached.emit()
		
	elif 'acid_puddle' in area.name:
		respawn()
	elif area.name == 'gun_prop':
		Eventbus.gun_picked_up.emit()
	elif area.name == 'level1_exit':
		get_tree().change_scene_to_file("res://level1_passed.tscn")
	elif area.name == 'jumpboots_prop':
		double_jump = true
	elif 'ammo1' in area.name:
		var ammo_type_event = 1
		ammo1 = ammo1 + 10;
		Eventbus.ammo_picked_up.emit(ammo_type_event)
	elif 'ammo2' in area.name:
		var ammo_type_event = 2
		ammo2 = ammo2 + 10
		Eventbus.ammo_picked_up.emit(ammo_type_event)
	elif 'jump_inc' in area.name:
		JUMP_VELOCITY = -800
	elif 'jump_dec' in area.name:
		JUMP_VELOCITY = -400
func _hitcheck():
	for area in $player_hitbox.get_overlapping_areas():
		if area.name == 'enemy_hitbox':
			Eventbus.player_hit.emit(hp)
			
func _grenade_hitcheck():
	for area in $player_hitbox.get_overlapping_areas():
		if area.name == 'grenade_hitbox':
			Eventbus.player_hit.emit(hp)


func _on_gun_iniciator_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
