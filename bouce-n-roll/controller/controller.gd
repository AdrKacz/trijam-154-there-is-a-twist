extends Spatial
signal fall

export (float, 500, 5000) var force_factor : float = 1000
export (float, 1, 10) var angle_factor : float = 1

onready var rigid_body : RigidBody = $RigidBody
onready var camera_root : Spatial = $CameraRoot
onready var camera : Camera = $CameraRoot/Camera

var direction : Vector3 = Vector3()
var input_movement_vector : Vector2 = Vector2()

func _physics_process(delta) -> void:
	process_input()
	process_movement(delta)
	
func _process(_delta) -> void:
	if translation.y < -10:
		emit_signal("fall")

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
		
