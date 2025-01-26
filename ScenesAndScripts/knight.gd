extends CharacterBody2D

@export var speed = 75
@export var chargespeed = 150
@export var activate = false

@onready var player: CharacterBody2D = $"../player"
@onready var knight: CharacterBody2D = $"."
@onready var timer: Timer = $Timer
@onready var pos = position

var need_to_check_direction = true
var dir = 1
var attack = false

func enable():
	activate = true

func check_dir():
	if position.x >= player.position.x:
		dir = -1
	else:
		dir = 1
	need_to_check_direction = false

func _physics_process(delta):
	if !attack:
		if position.x <= player.position.x:
			scale.x = 1
		else:
			scale.x = -1

	if activate:
		if position.y >= player.position.y -3 && position.y <= player.position.y + 3:
			attack = true
			print("CHARRRGE")
		elif position.y < player.position.y:
			if !attack:
				position.y+=delta*speed
		elif position.y > player.position.y:
			if !attack:
				position.y-=delta*speed

		if attack:
			position.x+=delta*chargespeed*dir
			if timer.is_stopped():
				timer.start()
			if need_to_check_direction:
				check_dir()

func _on_timer_timeout() -> void:
	position = pos
	activate = false
	need_to_check_direction = true
	dir = 1

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(0)
