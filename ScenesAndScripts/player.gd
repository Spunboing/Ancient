extends CharacterBody2D

@onready var i_frames: Timer = $"i-frames"
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var cam: Camera2D
@export var heartSprite: AnimatedSprite2D

@export var aliveTime: float = 0
@export var endGameScreen: Control


const SPEED = 8000.0

var mult = 1
var invincible = false
var hp = 5

var flickerTimer: float = 0

var increaseTime: bool = true



func _physics_process(delta: float) -> void:
	if increaseTime:
		aliveTime += delta
	flickerTimer += delta
	# Add the gravity.
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input.length() >= 0.1:
		
		if input.y > 0:
			$AnimatedSprite2D.play("walkDown")
		elif input.y < 0:
			$AnimatedSprite2D.play("walkUp")
		else:
			if input.x > 0:
				$AnimatedSprite2D.play("walkRight")
			elif input.x < 0:
				$AnimatedSprite2D.play("walkLeft")

	else:
		$AnimatedSprite2D.pause()
			
	velocity = input * SPEED * delta
	move_and_slide()
	if invincible == true and flickerTimer >= 0.1:
		$AnimatedSprite2D.visible = !$AnimatedSprite2D.visible
		flickerTimer = 0

func damage(extra):
	
	hp -= (1 + extra)*mult
	heartSprite.frame = hp - 1
	if not mult == 0:
		$hurt.play()
	print(hp)
	if invincible == false:
		
		invincible_frames()
	if hp <= 0:
		gameover()
	elif hp == 1:
		$mainMusic.stop()
		$lastHeartMusic.play()

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
	endGameScreen.visible = true
	endGameScreen.find_child("seconds").text = "\n[center]"+str(round(aliveTime))+"[/center]"
	increaseTime = false
	


func addShake(amount: float):
	cam.addShake(amount)
	



func _on_main_music_finished():
	$mainMusic.play()
	



func _on_last_heart_music_finished():
	$lastHeartMusic.play()
