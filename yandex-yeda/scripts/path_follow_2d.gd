extends PathFollow2D


var speed = 0.5
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready() -> void:
	Eventbus.attack_animation_start.connect(_stop)
	Eventbus.attack_animation_end.connect(_restart)
func _process(delta):
	progress_ratio += delta * speed
func _stop():
	set_process(false)
func _restart():
	set_process(true)
