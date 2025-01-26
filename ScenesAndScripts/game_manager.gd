extends Node2D

#Spikies
@onready var vert: Node = $"../Spike Things/Spike area 2ds/vert"
@onready var horizontal: Node = $"../Spike Things/Spike area 2ds/horizontal"
@onready var r1arr = get_tree().get_nodes_in_group("sr1")


@onready var timer: Timer = $Timer

@export var phase1: Array[Node2D]

var nextspike = true

func _ready():
	spike_spawns()

	timer.start()

func spike_spawns():
	for i in r1arr:
		i.enable()


func _on_timer_timeout():
	for device in phase1:
		if device.enabled == false:
			device.enable()
		elif device.enabled == true:
			device.disable()
		else:
			printerr("could not determine device state")
