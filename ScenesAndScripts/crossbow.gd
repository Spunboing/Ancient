extends AnimatedSprite2D

@export var enabled = false
var arrowPrefab:= preload("res://ScenesAndScripts/arrow.tscn")


#can be spawning, unloaded, loading, loaded
var loadState: String = "spawning"
var startLoadTime = 0

#called by game manager to enable device/enemy
func enable():
	print("enabling crossbow")
	visible = true
	enabled = true
	loadState = "spawning"
	scale = Vector2(0.5, 0.5)
	play("popUp_popDown")
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.3)
	await get_tree().create_timer(0.5).timeout
	loadState = "unloaded"
	
func disable():
	enabled = false
	play_backwards("popUp_popDown")
	await animation_finished
	visible = false
	enabled = false

func _process(delta):
	if enabled == true:
		if loadState == "unloaded":
			play("load")
			startLoadTime = Time.get_ticks_msec()
			loadState = "loading"
		elif loadState == "loading":
			if Time.get_ticks_msec() - startLoadTime >= 2000:
				loadState = "loaded"
		elif loadState == "loaded":
			print("fire")
			$AudioStreamPlayer2D.play()
			play("empty")
			var arrow = arrowPrefab.instantiate()
			get_tree().current_scene.add_child(arrow)
			arrow.global_position = global_position
			arrow.rotation = rotation
			loadState = "unloaded"
			
	
