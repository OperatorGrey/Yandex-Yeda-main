extends Label

@export var ammo1: int
@export var ammo2: int

func _ready() -> void:
	Eventbus.shots_fired.connect(_on_player_shoot)

func _on_player_shoot(ammo1, ammo2) -> void:
	text = ('Pizza bits: ') + str(ammo1) + '\n' + ('Street food: ') + str(ammo2)
