extends Area2D

var speed = 600
var direction : Vector2

func _process(delta: float) -> void:
	translate(direction * speed * delta)



func _on_area_entered(area: Area2D) -> void:
	if area.name == 'enemy_hitbox':
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	if body.name != 'player':
		if not 'grenade' in body.name:
			queue_free()
