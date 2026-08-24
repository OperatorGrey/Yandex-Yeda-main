extends Camera2D # Замените на Camera3D, если у вас 3D игра

var shake_intensity: float = 0.0
var shake_fade: float = 5.0

func _ready() -> void:
	Eventbus.grenade_explode.connect(shake)

func _process(delta: float) -> void:
	if shake_intensity > 0:
		# Плавное затухание тряски
		shake_intensity = lerp(shake_intensity, 0.0, shake_fade * delta)
		
		# Случайное смещение по осям X и Y
		offset.x = randf_range(-shake_intensity, shake_intensity)
		offset.y = randf_range(-shake_intensity, shake_intensity)
	else:
		offset = Vector2.ZERO # Возвращаем камеру в центр, если это Camera2D
		# Для Camera3D используйте: h_offset = 0.0 и v_offset = 0.0

# Этот метод вызывается при взрыве
func shake(intensity: float, fade_speed: float = 5.0) -> void:
	shake_intensity = intensity
	shake_fade = fade_speed
	
