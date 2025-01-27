extends Node2D

@onready var animation = $AnimatedSprite2D
@export var enabled: bool = false
@onready var sawSFX: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _animation():
	animation.play("default")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(0)
		

func enable():
	visible = true
	enabled = true
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(3).timeout
	sawSFX.play()
	
func disable():
	visible = false
	enabled = false
