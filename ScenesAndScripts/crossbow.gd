extends Sprite2D

@export var enabled = false
var arrowPrefab:= preload("res://ScenesAndScripts/arrow.tscn")


#can be unloaded, loading, loaded
var loadState: String = "unloaded"
var startLoadTime = 0

#called by game manager to enable device/enemy
func enable():
	print("enabling crossbow")
	visible = true
	enabled = true
	loadState = "unloaded"
	
func disable():
	print("disabling crossbow")
	visible = false
	enabled = false

func _process(delta):
	if enabled == true:
		if loadState == "unloaded":
			startLoadTime = Time.get_ticks_msec()
			loadState = "loading"
		elif loadState == "loading":
			if Time.get_ticks_msec() - startLoadTime >= 2000:
				loadState = "loaded"
		elif loadState == "loaded":
			print("fire")
			var arrow = arrowPrefab.instantiate()
			get_tree().current_scene.add_child(arrow)
			arrow.global_position = global_position
			arrow.rotation = rotation
			loadState = "unloaded"
			
	
