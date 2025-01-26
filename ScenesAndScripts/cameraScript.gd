extends Camera2D


@export var fadeStrength: float = 8.0

var rng = RandomNumberGenerator.new()

var shakeStrength: float = 0

func addShake(amount: float):
	shakeStrength += amount

func calculateOffset() -> Vector2:
	return Vector2(rng.randf_range(-shakeStrength, shakeStrength), rng.randf_range(-shakeStrength, shakeStrength))
	
func _process(delta):
	if shakeStrength > 0:
		shakeStrength = lerpf(shakeStrength, 0, min(1, fadeStrength * delta))
		offset = calculateOffset()
