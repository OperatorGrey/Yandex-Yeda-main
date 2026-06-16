extends Label


@export var ammo_type : Node2D

func _ready() -> void:
	Eventbus.ammo_type_changed.connect(_on_ammo_changed)

func _on_ammo_changed(ammo_type) -> void:
	if ammo_type == 1:
		text = ('Ammo type: pizza bits')
	elif ammo_type == 2:
		text = ('Ammo type: street food')
