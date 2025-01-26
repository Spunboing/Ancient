extends Node2D

@export var enabled = false

func enable():
	$AnimatedSprite2D.position = Vector2(0,0)
	print("enabling tile")
	visible = true
	enabled = true
	$AnimatedSprite2D.play("shake")
	await get_tree().create_timer(2).timeout
	$AnimatedSprite2D.play("fall")
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "position", Vector2(0, 48), 0.4)
	tween.tween_callback(shatter)
	
func disable():
	print("disabling tile")
	visible = false
	enabled = false
	
	
func shatter():
	for obj in $Area2D.get_overlapping_bodies():
		if obj.is_in_group("player"):
			obj.damage(0)
	visible = false
