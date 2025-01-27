extends Sprite2D




@export var speed: float

func _physics_process(delta):
	position += Vector2.RIGHT.rotated(rotation) * speed * delta


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		print("hit player")
		body.damage(0)
	queue_free()
