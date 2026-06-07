extends PathFollow2D


var speed = 0.5
# Called every frame. 'delta' is the elapsed time since the previous frame.

var is_attacking = false

var is_stunned = false

func _process(delta):
	if is_stunned == false and is_attacking == false:
		progress_ratio += delta * speed

func _stop():
	set_process(false)

func _restart():
	set_process(true)
