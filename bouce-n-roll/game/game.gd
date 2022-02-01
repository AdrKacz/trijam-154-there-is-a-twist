extends Spatial

export (int, 1, 10) var n_enemies = 2

onready var enemies : Spatial = $Enemies
onready var controller : Spatial = $Controller
onready var controller_rigid_body : RigidBody = controller.rigid_body

func _ready():
	enemies.spawn_enemies(n_enemies)

func _physics_process(_delta):
	enemies.update_target_all(controller.translation + controller_rigid_body.translation)
