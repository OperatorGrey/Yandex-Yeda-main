extends CharacterBody2D

@onready 
func _ready() -> void:
	player.hit.connect(_on_hit)



func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == 'player_hitbox':
		print('Bolno')
		emit_signal(hit)
