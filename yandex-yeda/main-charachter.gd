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
				$AudioStreamPlayer2D.stream = load("res://video-game-vintage-jump-ascend_zkbs6f4_.mp3")
				$AudioStreamPlayer2D.play()
		else:
			if double_jump == true:
				if jump_counter == 1:
					velocity.y = JUMP_VELOCITY
					jump_counter = 2
					$AudioStreamPlayer2D.stream = load("res://video-game-vintage-jump-ascend_zkbs6f4_.mp3")
					$AudioStreamPlayer2D.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
		#flip_h on left
	if Input.is_action_pressed("ui_left"):
		SPEED = 500
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = true
		$Sprite2D/AnimationPlayer.play('walking')
	elif Input.is_action_pressed("ui_right"):
		SPEED = 500
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = false
		$Sprite2D/AnimationPlayer.play('walking')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$Sprite2D/AnimationPlayer.stop()
	move_and_slide()
func respawn(): 
	velocity.x = 0
	ammo1 = 5
	ammo2 = 1
	position = start_pos
	Eventbus.shots_fired.emit(ammo1, ammo2)



func _on_hit(new_hp) -> void:
	if hp >= 1:
		hp = hp - 1
	else:
		hp = 3
		respawn()
	print(r'{hp}')
	move_and_slide()


func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if  'checkpoint' in area.name:
		start_pos = area.position
		Eventbus.checkpoint_reached.emit()
		
	elif 'acid_puddle' in area.name:
		respawn()
	elif area.name == 'gun_prop':
		Eventbus.gun_picked_up.emit()
		$Sprite2D.texture = load('res://main_charachter_with_gun.png')
		$AudioStreamPlayer2D.stream = load("res://jg-032316-sfx-8-bit-hit-6.mp3")
		$AudioStreamPlayer2D.play()
	elif area.name == 'level1_exit':
		get_tree().change_scene_to_file("res://level1_passed.tscn")
	elif area.name == 'jumpboots_prop':
		double_jump = true
		$AudioStreamPlayer2D.stream = load("res://jg-032316-sfx-8-bit-hit-6.mp3")
		$AudioStreamPlayer2D.play()
	elif 'ammo1' in area.name:
		var ammo_type_event = 1
		ammo1 = ammo1 + 10;
		Eventbus.ammo_picked_up.emit(ammo_type_event)
		Eventbus.shots_fired.emit(ammo1, ammo2)
		$AudioStreamPlayer2D.stream = load("res://jg-032316-sfx-8-bit-score-1.mp3")
		$AudioStreamPlayer2D.play()
	elif 'ammo2' in area.name:
		var ammo_type_event = 2
		ammo2 = ammo2 + 10
		Eventbus.ammo_picked_up.emit(ammo_type_event)
		Eventbus.shots_fired.emit(ammo1, ammo2)
		$AudioStreamPlayer2D.stream = load("res://jg-032316-sfx-8-bit-score-1.mp3")
		$AudioStreamPlayer2D.play()
	elif area.name == 'gun_iniciator':
		$Sprite2D.texture = load('res://main_charachter_with_gun.png')
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


func _on_audio_stream_player_2d_finished() -> void:
	pass # Replace with function body.
