extends CharacterBody2D


const SPEED = 8000.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input * SPEED * delta
	move_and_slide()
