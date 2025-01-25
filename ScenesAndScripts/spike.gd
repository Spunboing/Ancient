extends Node2D

@onready var spike: AnimatedSprite2D = $AnimatedSprite2D
@onready var warn: Timer = $warn
@onready var attack: Timer = $attack
@onready var hitbox: CollisionShape2D = $Area2D/CollisionShape2D


func _ready():
	activate()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.damage(0)

func activate():
	spike.play("warning")
	warn.start()

func _on_warn_timeout() -> void:
	hitbox.disabled = false
	spike.play("attack")
	attack.start()

func _on_attack_timeout() -> void:
	hitbox.disabled = true
	spike.play("retreat")
