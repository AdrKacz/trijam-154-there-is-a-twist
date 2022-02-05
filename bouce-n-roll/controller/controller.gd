extends Spatial
signal fall
signal hit_enemy(position, energy)

export (float, 500, 5000) var force_factor : float = 1000
export (float, 1, 10) var angle_factor : float = 1

export (int, 1, 10) var life : int = 3

onready var rigid_body : RigidBody = $RigidBody
onready var camera_root : Spatial = $CameraRoot
onready var camera : Camera = $CameraRoot/Camera
onready var movement_particle : CPUParticles = $CPUParticles

var direction : Vector3 = Vector3()
var input_movement_vector : Vector2 = Vector2()

func _physics_process(delta) -> void:
	process_input()
	process_movement(delta)
	movement_particle.global_transform.origin = rigid_body.global_transform.origin - Vector3(0, 1, 0)
	if (1.0 * rigid_body.linear_velocity.length_squared() > 30):
		movement_particle.emitting = true
	else:
		movement_particle.emitting = false
		
	if rigid_body.translation.y < -2:
		emit_signal("fall")
		
func reset_rigid_body() -> void:
	rigid_body.translation = Vector3(0, 2, 0)
	rigid_body.linear_velocity = Vector3(0, 0, 0)
	rigid_body.angular_velocity = Vector3(0, 0, 0)
	
func process_input() -> void:
	# Forces
	direction = Vector3()
	input_movement_vector = Vector2()
	
	var camera_xform : Transform = camera.global_transform
	
	if Input.is_action_pressed("ui_up"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("ui_down"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("ui_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_movement_vector.x += 1
	input_movement_vector = input_movement_vector.normalized()
	
	direction += - camera_xform.basis.z * input_movement_vector.y
	direction.y = 0
	direction = direction.normalized()
	
	
func process_movement(delta) -> void:
	rigid_body.add_force(direction * force_factor * delta, Vector3())
	camera_root.rotate_y(input_movement_vector.x * angle_factor * delta)
	
	
#func _input(event) -> void:
#	if event is InputEventMouseMotion:
#		var ray_from : Vector3 = GameGlobal.camera.project_ray_origin(event.position)
#		var ray_to : Vector3 = ray_from + GameGlobal.camera.project_ray_normal(event.position) * 100
		
func _on_RigidBody_body_entered(body) -> void:
	if body.is_in_group('enemy'):
		# Get Impact position and energy
		var impact_position : Vector3 = rigid_body.global_transform.origin + (body.global_transform.origin - rigid_body.global_transform.origin).normalized() * $RigidBody/CollisionShape.shape.radius;
		var v1 : Vector3 = rigid_body.linear_velocity
		var v2 : Vector3 = body.linear_velocity
		var impact_factor : float = 1.0 - v1.normalized().dot(v2.normalized()) # Between 0 and 2
		var impact_energy : float = (1.0 * v1.length_squared() + 1.0 * v2.length_squared()) * impact_factor
		# Alert Game
		emit_signal("hit_enemy", impact_position, impact_energy)
