extends CharacterBody2D

var grenade_prefab = preload("res://grenade.tscn")

var hitpoints = 5

var num_grenades = 1

var attack_left = true

func _attack():
	$'attack_timer'.start()
	get_parent().is_attacking=true
	shoot()
func _stun():
	$'stun_timer'.start()
	get_parent().is_stunned=true


func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "bullet":
		hitpoints = hitpoints - 1
	elif area.name == "bullet1":
		hitpoints = hitpoints - 2
		_stun()
	if hitpoints <= 0:
		queue_free()

func _on_timer_timeout() -> void:
	Eventbus.attack_animation_end.emit()
	if $enemy_hitbox.has_overlapping_areas():
		for area in $enemy_hitbox.get_overlapping_areas():
			if area.name == 'player_hibox':
				_attack()
	else:
		get_parent().is_attacking=false

func _on_stun_timer_timeout() -> void:
	get_parent().is_stunned=false
	

func _on_left_vision_area_entered(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = true
		_attack()
func _on_right_vision_area_entered(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = false
		_attack()


func spawn_bullet(direction : Vector2):
		# Spawn a bullet
	var grenade
	grenade = grenade_prefab.instantiate()
	if attack_left == true:
		grenade.position = global_position - Vector2(-100, 0)
	grenade.direction = direction 
	get_tree().root.add_child(grenade)
	print('grenade thrown')

func shoot():
	var direction
	if attack_left == true:
		direction = Vector2.LEFT
		get_child(grenade_prefab).throwing_direction_right = false
	elif attack_left == false:
		direction = Vector2.RIGHT
		get_child(grenade_prefab).throwing_direction_right = true
	var step = 2*PI / num_grenades
	for i in range(num_grenades):
		spawn_bullet(direction)
		#rotate direction
		direction = direction.rotated(step)
