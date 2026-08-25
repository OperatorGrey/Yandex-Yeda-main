extends CharacterBody2D

var grenade_prefab = preload("res://grenade.tscn")
@onready var sprite = $Sprite2D

var hitpoints = 5

var num_grenades = 1

var going_left = true

var attacking = false
var walking = true
var stunned = false

var attack_left = true

var grenade_serial_number

func _ready() -> void:
	Eventbus.grenade_explosion.connect(_on_explode)

func _attack():
	if $'attack_timer'.is_stopped():
		$'attack_timer'.start()
	get_parent().is_attacking=true
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
		print('hit')
		$AudioStreamPlayer2D2.play()
	elif area.name == "bullet1":
		hitpoints = hitpoints - 2
		_stun()
		print('hit')
		$AudioStreamPlayer2D2.play()
	if hitpoints <= 0:
		get_parent().dead = true
		queue_free()


func _on_stun_timer_timeout() -> void:
	get_parent().is_stunned=false
	

func _on_left_vision_area_entered(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = true
		attacking = true

func _on_right_vision_area_entered(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = false
		attacking = true

func _on_left_vision_area_exited(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = true
		attacking = false

func _on_right_vision_area_exited(area: Area2D) -> void:
	if area.name == "player_hitbox":
		attack_left = false
		attacking = false

func spawn_bullet():
		# Spawn a bullet
	var grenade
	grenade = grenade_prefab.instantiate()
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
	if attacking == true:
		get_parent().is_attacking = true
		_attack()
	else:
		get_parent().is_attacking = false
	if walking == true:
		$Sprite2D/AnimationPlayer.play("walking")
	elif stunned == true:
		$Sprite2D/AnimationPlayer.play("stunned")
	elif attacking == true:
		$Sprite2D/AnimationPlayer.stop()
	elif attacking == false and stunned == false:
		walking = true

func _on_explode():
	$AudioStreamPlayer2D.play()
