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

#bat array
@onready var batarr = get_tree().get_nodes_in_group("bat")

#Timers
@onready var phase_timer: Timer = $phase_time
@onready var spikecyctime: Timer = $spikecyctime
@onready var knight_cycle_time: Timer = $knight_cycle_time
@onready var bat_time: Timer = $bat_time


@export var phase = 1
@export var phase1: Array[Node2D]
@export var nextspike = 10

func _ready():
	spike_spawns()
	knight_spawns()
	bat_spawns()


#Handles all bat traps
func bat_spawns():
	if phase == 2:
		batarr[int(randf_range(0,batarr.size()-1))].enable()
	elif phase == 3:
		batarr[0].enable()
		batarr[1].enable()
	
	bat_time.start()


#Handles all knight traps
func knight_index():
	return int(randf_range(0,knightarr.size()-1))
	
func knight_spawns():
		for i in phase:
			var ind = knight_index()
			if !(knightarr[ind].gogo):
				print("hi")
				knightarr[ind].enable()
	
#Handles all spike traps
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

#Moves to next phase every minute until phase 3 is reached
func _on_phase_time_timeout() -> void:
	if phase < 3:
		phase += 1
	if phase == 2:
		bat_spawns()


func _on_bat_time_timeout() -> void:
	pass # Replace with function body.
