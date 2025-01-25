extends CharacterBody2D

@onready var player: CharacterBody2D = $"../player"
@export var speed = 50
var player_pos
var target_pos


func _process(delta):
	
	player_pos = player.position
	target_pos = (player_pos - position).normalized()
	
	if position.distance_to(player_pos) > 3:
		velocity = target_pos*speed
		move_and_slide()
		look_at(player_pos)

	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(0)
