extends Label


@export var ammo_type : Node2D

func _ready() -> void:
	Eventbus.ammo_type_changed.connect(_on_ammo_changed)

func _on_ammo_changed(ammo_type) -> void:
	text = ('Ammo type: ') + str(ammo_type)
