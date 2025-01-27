extends CharacterBody2D

@onready var player: CharacterBody2D = $"../../player"
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var timer: Timer = $Timer
@onready var pos = position

@export var speed = 50
var player_pos
var target_pos
var active = false
var goaway = false

func enable():
	timer.start()
	active = true
	collision_shape_2d.disabled = false

func disable():
	goaway = true
	active = false
	collision_shape_2d.disabled = true
	await get_tree().create_timer(3).timeout
	goaway = false
	position = pos

func _process(delta):
	if active:
		player_pos = player.position
		target_pos = (player_pos - position).normalized()
		
		if position.distance_to(player_pos) > 3:
			velocity = target_pos*speed
			move_and_slide()
			look_at(player_pos)
			rotation = rotation - (PI/2)

func _physics_process(delta):
	if goaway:
		position.y += 1000*delta
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(0)

func _on_timer_timeout() -> void:
	disable()
