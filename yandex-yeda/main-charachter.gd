extends CharacterBody2D

var start_pos = Vector2 (142.0, 448.0)
var SPEED = 0.0
const JUMP_VELOCITY = -400.0
var hp = 3


func _ready() -> void:
	Eventbus.attack_animation_end.connect(_hitcheck)
	Eventbus.player_hit.connect(_on_hit)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
		#flip_h on left
	if Input.is_action_pressed("ui_left"):
		SPEED = 300
		velocity.x = direction * SPEED
	elif Input.is_action_pressed("ui_right"):
		SPEED = 300
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
	move_and_slide()


func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if  area.name == 'checkpoint':
		start_pos = area.position
		
	elif 'acid_puddle' in area.name:
		respawn()
	elif area.name == 'gun_prop':
		Eventbus.gun_picked_up.emit()
	elif area.name == 'level1_exit':
		get_tree().change_scene_to_file("res://level1_passed.tscn")

func _hitcheck():
	for area in $player_hitbox.get_overlapping_areas():
		if area.name == 'enemy_hitbox':
			Eventbus.player_hit.emit(hp)
