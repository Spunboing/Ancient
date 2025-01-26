extends Node2D

#Spikies
@onready var vert: Node = $"../Spike Things/Spike area 2ds/vert"
@onready var horizontal: Node = $"../Spike Things/Spike area 2ds/horizontal"
@onready var r1arr = get_tree().get_nodes_in_group("sr1")
@onready var r2arr = get_tree().get_nodes_in_group("sr2")
@onready var r3arr = get_tree().get_nodes_in_group("sr3")
@onready var r4arr = get_tree().get_nodes_in_group("sr4")

#Timers
@onready var timer: Timer = $Timer
@onready var spikecyctime: Timer = $spikecyctime


@export var phase1: Array[Node2D]

var nextspike = 10

func _ready():
	spike_spawns()

	timer.start()

func spike_spawns():
	for i in r1arr:
		i.enable()
	await get_tree().create_timer(nextspike).timeout
	for i in r2arr:
		i.enable()
	await get_tree().create_timer(nextspike).timeout
	for i in r3arr:
		i.enable()
	await get_tree().create_timer(nextspike).timeout
	for i in r4arr:
		i.enable()
	if nextspike > 5:
		nextspike -= 6
