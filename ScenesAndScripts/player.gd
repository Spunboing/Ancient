extends CharacterBody2D

@onready var i_frames: Timer = $"i-frames"
@onready var sprite_2d: Sprite2D = $Sprite2D

const SPEED = 8000.0

var mult = 1
var invincible = false
var hp = 5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input * SPEED * delta
	move_and_slide()
	if invincible == true:
		sprite_2d.visible = !sprite_2d.visible

func damage(extra):
	hp -= (1 + extra)*mult
	print(hp)
	if invincible == false:
		invincible_frames()
	if hp <= 0:
		gameover()

func invincible_frames():
	("safe")
	mult = 0
	invincible = true
	i_frames.start()
			
func _on_iframes_timeout() -> void:
	print("unsafe")
	mult = 1
	invincible = false
	sprite_2d.visible = true

func gameover():
	print("YOU DIED :(")
