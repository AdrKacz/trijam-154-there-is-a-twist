extends Spatial

export (float) var force_factor : float = 500
export (float) var break_force_factor: float = 1000

var target : Vector3 = Vector3()

onready var rigid_body : RigidBody = $RigidBody

func _physics_process(delta):
	var direction : Vector3 = target - rigid_body.global_transform.origin
	direction.y = 0
	direction = direction.normalized()
	# Is direction toward velocity
	if direction.dot(rigid_body.linear_velocity) < 0:
		rigid_body.add_force(direction * break_force_factor * delta, Vector3())
	else:
		rigid_body.add_force(direction * force_factor * delta, Vector3())
