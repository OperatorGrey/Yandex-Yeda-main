#extends PathFollow2D
#
#@onready var sprite: Sprite2D = $CharacterBody2D/Sprite2D
#
#var speed = 0.5
## Called every frame. 'delta' is the elapsed time since the previous frame.
#
#var is_attacking = false
#
#var is_stunned = false
#
#func _process(delta):
	#if is_stunned == false and is_attacking == false:
		#progress_ratio += delta * speed
	#if progress_ratio >= 1.0 and speed > 0:
		#print("flip")
		#sprite.flip_h != sprite.flip_h
#func _stop():
	#set_process(false)
#
#func _restart():
	#set_process(true)

#extends PathFollow2D
#
#@onready var sprite: Sprite2D = $CharacterBody2D/Sprite2D
#
#var speed = 0.5
#var is_attacking = false
#var is_stunned = false
#
## Переменная для слежения за прошлым кадром
#var last_progress = 0.0
#
#func _ready():
	#rotates = false # Отключаем переворот вверх ногами
#
#func _process(delta):
	#if not is_stunned and not is_attacking:
		#progress_ratio += delta * speed
	#
	## Если в прошлый кадр прогресс был большим (конец круга), 
	## а сейчас стал маленьким (начало круга) — значит мы пересекли черту
	#if progress_ratio < last_progress:
		#print("flip - круг завершен!")
		#sprite.flip_h = !sprite.flip_h # Меняем сторону спрайта
		#
	## Запоминаем текущий прогресс для следующего кадра
	#last_progress = progress_ratio


extends PathFollow2D

@onready var sprite: Sprite2D = $CharacterBody2D/Sprite2D

var speed = 0.5
var is_attacking = false
var is_stunned = false
var dead = false

func _ready():
	rotates = false # Отключаем переворот вверх ногами

func _process(delta):
	if dead == true:
		set_process(false)
		return
	if not is_stunned and not is_attacking:
		progress_ratio += delta * speed
	
	# ХОД ВПЕРЕД (speed > 0)
		if speed > 0:
		# На первой половине пути (от 0.0 до 0.5) смотрит вправо
			if progress_ratio < 0.5:
				#sprite.flip_h = false
				get_child(0).going_left = false
		# Как только пересек середину (0.5), разворачивается влево
			elif progress_ratio >= 0.5 and progress_ratio < 1.0:
				#sprite.flip_h = true
				get_child(0).going_left = true
		# Дошел до конца (1.0) — разворачивается и идет назад
			elif progress_ratio >= 1.0:
				speed = -speed
			
	# ХОД НАЗАД (speed < 0)
		elif speed < 0:
#		get_child(0).going_left = false
		# На обратном пути от конца до середины смотрит влево
			if progress_ratio > 0.5:
				sprite.flip_h = true
		# Пересек середину обратно — снова смотрит вправо
			elif progress_ratio <= 0.5 and progress_ratio > 0.0:
				sprite.flip_h = false
		# Вернулся в самое начало (0.0) — идет вперед
			elif progress_ratio <= 0.0:
				speed = -speed
