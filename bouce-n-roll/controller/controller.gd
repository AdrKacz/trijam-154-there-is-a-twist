extends RigidBody

export (float) var speed : float = 10

var direction : Vector3 = Vector3()
var jump : bool = false

func _ready():
	respawn()

func _physics_process(delta) -> void:
	process_input()
	process_movement(delta)
	
func _process(_delta) -> void:
	if translation.y < -10:
		respawn()
		
func respawn() -> void:
	var theta : float = randf() * PI * 2
	var r : float = randf() * 3
	
	translation = Vector3(
		r * cos(theta),
		2,
		r * sin(theta)
	)
	
func process_input() -> void:
	# Forces
	direction = Vector3()
	
	var input_movement_vector : Vector2 = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("ui_down"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("ui_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_movement_vector.x += 1
	input_movement_vector = input_movement_vector.normalized()
	
	direction.x = input_movement_vector.x
	direction.z = - input_movement_vector.y
	
	
#	# Jump, TODO: Is on floor
	if Input.is_action_just_pressed("ui_jump"):
		jump = true
	
func process_movement(delta) -> void:
	direction.y = 0
	apply_impulse(Vector3(0, 0.2, 0), delta * direction * speed)
	if jump:
		jump = false
		apply_impulse(Vector3(0, -0.2, 0), Vector3(0, 3, 0))
	
	
#func _input(event) -> void:
#	if event is InputEventMouseMotion:
#		var ray_from : Vector3 = GameGlobal.camera.project_ray_origin(event.position)
#		var ray_to : Vector3 = ray_from + GameGlobal.camera.project_ray_normal(event.position) * 100
		
