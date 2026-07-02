extends CPUParticles2D

var going_left

func _process(delta: float) -> void:
	going_left = get_parent(1).going_left
	if going_left == true:
		global_position = 
