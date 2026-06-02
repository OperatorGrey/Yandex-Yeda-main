extends CharacterBody2D

var grenade_prefab = preload("res://grenade.tscn")

var hitpoints = 5

func _attack():
	$'attack_timer'.start()
	get_parent().is_attacking=true
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
	
