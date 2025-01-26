extends Node2D

@onready var timer: Timer = $Timer

@export var phase1: Array[Node2D]

func _ready():
	timer.start()
	

func _on_timer_timeout():
	for device in phase1:
		if device.enabled == false:
			device.enable()
		elif device.enabled == true:
			device.disable()
		else:
			printerr("could not determine device state")
