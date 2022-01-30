extends RigidBody

export (float) var rotation_speed : float = 8

func _ready():
	rotate_positive()
	
func rotate_positive():
	add_torque(Vector3.UP * rotation_speed * 1e3)

func rotate_negative():
	add_torque(Vector3.DOWN * rotation_speed * 1e3)
