extends Node2D

#Spikies
@onready var vert: Node = $"../Spike Things/Spike area 2ds/vert"
@onready var horizontal: Node = $"../Spike Things/Spike area 2ds/horizontal"
@onready var r1arr = get_tree().get_nodes_in_group("sr1")
@onready var r2arr = get_tree().get_nodes_in_group("sr2")
@onready var r3arr = get_tree().get_nodes_in_group("sr3")
@onready var r4arr = get_tree().get_nodes_in_group("sr4")

#crossbow array
@onready var crossbowarr = get_tree().get_nodes_in_group("crossbow")

#sword array
@onready var swordarr = get_tree().get_nodes_in_group("sword")

#saw player
@onready var sawplayer: AnimationPlayer = $"../sawblades/AnimationPlayer"
@onready var sawarr = get_tree().get_nodes_in_group("saw")

#Knights
@onready var knightarr = get_tree().get_nodes_in_group("knight")

#bat array
@onready var batarr = get_tree().get_nodes_in_group("bat")

#ceiling array
@onready var ceilingarr = get_tree().get_nodes_in_group("ceiling")

#rat array
@onready var ratarr = get_tree().get_nodes_in_group("rat")

#Timers
@onready var phase_time: Timer = $phase_time
@onready var spikecyctime: Timer = $spikecyctime
@onready var knight_cycle_time: Timer = $knight_cycle_time
@onready var bat_time: Timer = $bat_time
@onready var ceiling_time: Timer = $ceiling_time
@onready var initial_knight_delay: Timer = $initial_knight_delay

@export var sawtime = 5
@export var knighttime = 15
@export var phase = 1
@export var phase1: Array[Node2D]
@export var nextspike = 10

func _ready():
	spike_spawns()
	ceiling_spawns()
	rat_spawns()
	sword_spawns()
	crossbow_spawns()
	await get_tree().create_timer(3).timeout
	knight_spawns()


func crossbow_spawns():
	for i in crossbowarr:
		i.enable()

func sword_spawns():
	for i in swordarr:
		print(i)
		i.enable()

func rat_spawns():
	for i in ratarr:
		print(i)
		i.enable()

func saw_spawns():
	for i in sawarr:
		i.enable()
	sawplayer.play("move")
	await get_tree().create_timer(sawtime).timeout

func ceiling_index():
	return int(randf_range(0,ceilingarr.size()-1))
	
func ceiling_spawns():
	for i in phase*10:
		var ind = ceiling_index()
		await get_tree().create_timer(.3).timeout
		ceilingarr[ind].enable()
		
	ceiling_time.start()

func _on_ceiling_time_timeout() -> void:
	print("lndon")
	ceiling_spawns()
	
	
#Handles all bat traps
func bat_spawns():
	if phase == 2:
		batarr[int(randf_range(0,batarr.size()-1))].enable()
	elif phase == 3:
		batarr[0].enable()
		batarr[1].enable()
	
	bat_time.start()

func _on_bat_time_timeout() -> void:
	bat_spawns()
	
#Handles all knight traps
func knight_index():
	return int(randf_range(0,knightarr.size()-1))
	
func knight_spawns():
	var loop
	if phase == 1:
		loop = 1
	else:
		loop = 2
	for i in loop:
		var ind = knight_index()
		if !(knightarr[ind].gogo):
			print("hi")
			knightarr[ind].enable()
	await get_tree().create_timer(knighttime).timeout
	print("knighty knight")
	knight_spawns()
	
	
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
	if phase == 3:
		knighttime = 15
		saw_spawns()
	print ("now on phase " + str(phase))
