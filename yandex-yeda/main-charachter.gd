extends CharacterBody2D

signal hit
var start_pos = Vector2 (142.0, 448.0)
const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		#flip_h on left
	move_and_slide()
func respawn(): 
	velocity.x = 0
	
	position = start_pos




func _on_hit() -> void:
	respawn()
	
	move_and_slide()


func _on_player_hitbox_area_entered(area: Area2D) -> void:
	if area.name == 'enemy_hitbox' or 'acid_puddle' in area.name:
		print('Bolno')
		hit.emit()
	elif  area.name == 'checkpoint':
		start_pos = area.position
