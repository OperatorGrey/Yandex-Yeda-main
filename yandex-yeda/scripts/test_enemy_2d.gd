extends CharacterBody2D

@onready var particles = $Sprite2D/CPUParticles2D
@onready var sprite = $Sprite2D

var hitpoints = 5

var going_left = true

var stunned = false
var walking = true
var attacking = false

func _attack():
	$'attack_timer'.start()
	get_parent().is_attacking=true
	$AudioStreamPlayer2D.play()
	attacking = true
	walking = false
func _stun():
	$'stun_timer'.start()
	get_parent().is_stunned=true
	stunned = true
	walking = false


func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "bullet":
		hitpoints = hitpoints - 1
	elif area.name == "bullet1":
		hitpoints = hitpoints - 2
		_stun()
		stunned = true
	if area.name == "player_hitbox":
		_attack()
		attacking = true
		if going_left == true:
			particles.position.x = 63.2643737792969
			print('swapped left')
		elif going_left == false:
			particles.position.x = 63.2643737792969
			print('swapped right')

func _on_timer_timeout() -> void:
	Eventbus.attack_animation_end.emit()
	if $enemy_hitbox.has_overlapping_areas():
		for area in $enemy_hitbox.get_overlapping_areas():
			if area.name == 'player_hitbox':
				_attack()
				attacking = true
			else:
				$AudioStreamPlayer2D.stop()
	else:
		get_parent().is_attacking=false
		attacking = false
		walking = true

func _on_stun_timer_timeout() -> void:
	get_parent().is_stunned=false
	stunned = false

func _process(delta: float) -> void:
#Take a look at the Enums, will fix a lot of problems with animations
	if going_left == true:
		scale.x = -1
	elif going_left == false:
		scale.x = 1
	if walking == true:
		$Sprite2D/AnimationPlayer.play("walking")
	elif attacking == true:
		$Sprite2D/AnimationPlayer.play("hitting the player")
	elif stunned == true:
		$Sprite2D/AnimationPlayer.play("stunned")
	if hitpoints <= 0:
		get_parent().dead = true
		queue_free()

#Take a look at the Enums, will fix a lot of problems with animations
#	if going_left == true:
#		scale.x = 1
#		particles.position.x = 63.2643737792969
#	elif going_left == false:
#		scale.x = -1
#		particles.position.x = -63.2643737792969
