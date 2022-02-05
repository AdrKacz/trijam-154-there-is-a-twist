extends Spatial

signal no_more_enemy
signal controller_died

export (int, 1, 10) var n_enemies : float = 2

var enemies_alive : float

onready var enemies : Spatial = $Enemies
onready var controller : Spatial = $Controller
onready var controller_rigid_body : RigidBody = controller.rigid_body

func _ready() -> void:
	spawn_enemies()
	
func spawn_enemies():
	enemies.spawn_enemies(n_enemies)
	enemies_alive = n_enemies

func _physics_process(_delta) -> void:
	enemies.update_target_all(controller_rigid_body.global_transform.origin)


func _on_Controller_fall() -> void:
	# TODO: Animation
	controller.life -= 1
	if controller.life <= 0:
		emit_signal("controller_died")
		Game.load_menu_scene()
	else:
		controller.reset_rigid_body()


func _on_Enemies_enemy_fall() -> void:
	enemies_alive -= 1
	if enemies_alive <= 0:
		emit_signal("no_more_enemy")
		n_enemies += 1
		spawn_enemies()
