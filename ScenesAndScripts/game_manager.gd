extends Node2D

#Spikies
@onready var vert: Node = $"../Spike Things/Spike area 2ds/vert"
@onready var horizontal: Node = $"../Spike Things/Spike area 2ds/horizontal"
@onready var r1arr = get_tree().get_nodes_in_group("sr1")
@onready var r2arr = get_tree().get_nodes_in_group("sr2")
@onready var r3arr = get_tree().get_nodes_in_group("sr3")
@onready var r4arr = get_tree().get_nodes_in_group("sr4")

#Knights
@onready var knightarr = get_tree().get_nodes_in_group("knight")

#Timers
@onready var phase_timer: Timer = $phase_time
@onready var spikecyctime: Timer = $spikecyctime
@onready var knight_cycle_time: Timer = $knight_cycle_time

@export var phase = 1
@export var phase1: Array[Node2D]
@export var nextspike = 10

func _ready():
	spike_spawns()
	knight_spawns()



func knight_index():
	return int(randf_range(0,knightarr.size()-1))
	
func knight_spawns():
		for i in phase:
			var ind = knight_index()
			if !(knightarr[ind].gogo):
				print("hi")
				knightarr[ind].enable()
	

func spike_spawns():
	for i in r1arr:
		i.enable()
	await get_tree().create_timer(nextspike/phase).timeout
	for i in r2arr:
		i.enable()
	await get_tree().create_timer(nextspike/phase).timeout
	for i in r3arr:
		i.enable()
	await get_tree().create_timer(nextspike/phase).timeout
	for i in r4arr:
		i.enable()
	spike_spawns()


func _on_phase_time_timeout() -> void:
	if phase < 3:
		phase += 1
