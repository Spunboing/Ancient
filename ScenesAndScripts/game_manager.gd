extends Node2D

#Spikies
@onready var spike_7: Node = $spike7
@onready var spike_6: Node = $spike6
@onready var spike_5: Node = $spike5
@onready var spike_4: Node = $spike4
@onready var spike_3: Node = $spike3
@onready var spike_2: Node = $spike2
@onready var spike: Node = $spike


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
