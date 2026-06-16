extends Label

@export var ammo_type_event : CharacterBody2D

func _ready() -> void:
	Eventbus.ammo_picked_up.connect(_on_ammo_picked_up)

func _on_ammo_picked_up(ammo_type_event) -> void:
	$Timer.start()
	if ammo_type_event == 1:
		text = ('Pizza bits picked up (+10)')
	elif ammo_type_event == 2:
		text = ('Street food picked up (+10)')
	visible = true

func _on_timer_timeout() -> void:
	visible = false
