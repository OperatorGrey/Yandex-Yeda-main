extends Label

@export var ammo_type_event : CharacterBody2D

func _ready() -> void:
	Eventbus.ammo_picked_up.connect(_on_ammo_picked_up)
	Eventbus.checkpoint_reached.connect(_on_checkpoint_reached)
	Eventbus.gun_picked_up.connect(_on_gun_picked_up)
	Eventbus.jumpboots_picked_up.connect(_on_jumpboots_picked_up)

func _on_ammo_picked_up(ammo_type_event) -> void:
	$Timer.start()
	if ammo_type_event == 1:
		text = ('Pizza bits picked up (+10)')
	elif ammo_type_event == 2:
		text = ('Street food picked up (+10)')
	visible = true
	
func _on_checkpoint_reached():
	$Timer.start()
	text = ('Checkpoint reached')
	visible = true

func _on_timer_timeout() -> void:
	visible = false
	
func _on_gun_picked_up():
	$Timer.start()
	text = ('Gun is picked up')
	visible = true
func _on_jumpboots_picked_up():
	$Timer.start()
	text = ('Jumpboots are picked up')
	visible = true
