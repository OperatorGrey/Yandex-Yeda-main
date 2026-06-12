extends CharacterBody2D

var bullet_prefab = preload("res://bullet.tscn")

var hitpoints = 5

var num_grenades = 1

var is_attacking = false

var attack_left = true

var grenade_serial_number

func _attack():
	if $'attack_timer'.is_stopped():
		$'attack_timer'.start()
	
func _stun():
	$'stun_timer'.start()
	get_parent().is_stunned=true


func _on_enemy_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "bullet":
		hitpoints = hitpoints - 1
		print('hit')
	elif area.name == "bullet1":
		hitpoints = hitpoints - 2
		_stun()
		print('hit')
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
	grenade = bullet_prefab.instantiate()
	if attack_left == true:
		get_tree().root.add_child(grenade)
		grenade.position = global_position - Vector2(100, 0)
		grenade.name = 'grenade'
		grenade.throw_grenade(attack_left)
	elif attack_left == false:
		get_tree().root.add_child(grenade)
		grenade.position = global_position - Vector2(-100, 0)
		grenade.name = 'grenade'
		grenade.throw_grenade(attack_left)
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
