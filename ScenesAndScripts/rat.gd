extends AnimatedSprite2D

@export var enabled: bool = false
@export var SPEED: float

var running = false

@onready var startPos = global_position

# Called when the node enters the scene tree for the first time.
func enable():
	print("enabling rat")
	global_position = startPos
	rotation = randf_range(-180, 180)
	visible = true
	enabled = true
	running = true
	
func disable():
	print("disabling rat")
	visible = false
	enabled = false

var rayHitPoint
var rayDir

func _draw():
	if rayHitPoint:
		draw_line(to_local(rayHitPoint), to_local(rayHitPoint+(rayDir.rotated(PI/2))*10), Color.RED)
	draw_line(Vector2.ZERO, to_local(global_position+Vector2(cos(rotation), sin(rotation))) * 10, Color.GREEN)

func _process(delta):
	var spaceState = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(global_position, global_position+(Vector2.RIGHT.rotated(rotation) * 10))
	query.exclude = [self]
	var result = spaceState.intersect_ray(query)
	
	if running:
		position += Vector2.RIGHT.rotated(rotation) * delta * SPEED
	if result:
		if result.collider.is_in_group("player"):
			result.collider.damage(0)
		else:
			var setAngle = (Vector2(cos(rotation), sin(rotation)).bounce(result.normal).angle())
			rayHitPoint = result.position
			rayDir = result.normal
			rotation = setAngle
			if result.collider.is_in_group("player"):
				result.collider.damage(0)
			
