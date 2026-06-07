extends CharacterBody2D

var grenade_prefab = preload("res://grenade.tscn")

var hitpoints = 5

var num_grenades = 1

var is_attacking = false

var attack_left = true

func _attack():
	if $'attack_timer'.is_stopped():
		$'attack_timer'.start()
	
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


func _on_stun_timer_timeout() -> void:
	get_parent().is_stunned=false
	

func _on_left_vision_area_entered(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = true
		is_attacking = true

func _on_right_vision_area_entered(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = false
		is_attacking = true

func _on_left_vision_area_exited(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = true
		is_attacking = false

func _on_right_vision_area_exited(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = false
		is_attacking = false

func spawn_bullet():
		# Spawn a bullet
	var grenade
	grenade = grenade_prefab.instantiate()
	if attack_left == true:
		get_tree().root.add_child(grenade)
		grenade.position = global_position - Vector2(100, 0)
		grenade.throwing_direction_right = false
	print('grenade thrown')
	

func _on_timer_timeout() -> void:
	print('1')
	spawn_bullet()
	$'attack_timer'.stop()


func _process(delta: float) -> void:
	if is_attacking == true:
		get_parent().is_attacking = true
		_attack()
	else:
		get_parent().is_attacking = false
