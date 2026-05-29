extends Label

@export var hp : CharacterBody2D

func _ready() -> void:
	Eventbus.player_hit.connect(_on_player_hit)

func _on_player_hit(new_hp) -> void:
	text = ('HP: ') + str(new_hp)
