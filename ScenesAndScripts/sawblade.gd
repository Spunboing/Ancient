extends Node2D

@onready var animation = $AnimatedSprite2D
@export var enabled: bool = false


func _animation():
	animation.play("default")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(0)
		

func enable():
	visible = true
	enabled = true

	
func disable():
	visible = false
	enabled = false
