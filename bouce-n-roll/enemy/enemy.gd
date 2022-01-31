extends Spatial


export (float) var force_factor : float = 100

var target : Vector3 = Vector3()

onready var rigid_body : RigidBody = $RigidBody

func _physics_process(delta):
	var direction : Vector3 = target - (translation + rigid_body.translation)
	direction.y = 0
	direction = direction.normalized()

	rigid_body.add_force(direction * force_factor * delta, Vector3())
	
	
