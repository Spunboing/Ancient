extends Node2D

@export var enabled = false
var checkedDamage:= false
var falling = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func enable():
	print("enabling sword")
	modulate = Color.WHITE
	visible = true
	enabled = true
	checkedDamage = false
	falling = false
	$AnimatedSprite2D.play("shake")
	await get_tree().create_timer(2).timeout
	falling = true
	$AnimatedSprite2D.play("fall")
	
func _process(delta):
	if falling:
		if $AnimatedSprite2D.frame >= 3 and checkedDamage == false:
			for obj in $Area2D.get_overlapping_bodies():
				if obj.is_in_group("player"):
					print("hit player")
					checkedDamage = true
					obj.damage(0)
func disable():
	print("disabling sword")
	visible = false
	enabled = false




func _on_animated_sprite_2d_animation_finished():
	if falling:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "modulate", Color.TRANSPARENT, 1)
		tween.tween_callback(setInvisible)


func setInvisible():
	visible = false
