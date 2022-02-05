extends Spatial

signal fall

export (float) var force_factor : float = 500
export (float) var break_force_factor: float = 1000

var target : Vector3 = Vector3()
var is_dead : bool = false

onready var rigid_body : RigidBody = $RigidBody

func _physics_process(delta):
	if is_dead:
		return
	var direction : Vector3 = target - rigid_body.global_transform.origin
	direction.y = 0
	direction = direction.normalized()
	# Is direction toward velocity
	if direction.dot(rigid_body.linear_velocity) < 0:
		rigid_body.add_force(direction * break_force_factor * delta, Vector3())
	else:
		rigid_body.add_force(direction * force_factor * delta, Vector3())
		
	if (rigid_body.translation.y < -2):
		is_dead = true
		emit_signal("fall")
