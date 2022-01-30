extends RigidBody

export (float) var speed : float = 10

var target : Vector3 = Vector3()
var squared_distance_to_target : float = 0

func _ready():
	respawn()
	
func _physics_process(delta) -> void:
	process_target()
	process_movement(delta)

func _process(_delta):
	if translation.y < -10:
		respawn()
		
func respawn():
	var theta : float = randf() * PI * 2
	var r : float = randf() * 3
	
	translation = Vector3(
		r * cos(theta),
		2,
		r * sin(theta)
	)
	
func process_target():
	target = GameGlobal.item_translation - translation
	target.y = 0
	squared_distance_to_target = target.length_squared()
	target = target.normalized()
	
func process_movement(delta):
	apply_impulse(Vector3(0, 0.2, 0), delta * target * speed * clamp(squared_distance_to_target / 100, 0, 1))
