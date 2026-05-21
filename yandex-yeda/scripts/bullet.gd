extends Area2D


var speed = 600
var direction : Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	translate(direction * speed * delta)



func _on_area_entered(area: Area2D) -> void:
	if area.name == 'enemy_hitbox':
		queue_free()
