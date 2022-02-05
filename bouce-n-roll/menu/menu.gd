extends Spatial

export (PackedScene) var enemy_scene : PackedScene

export (float) var min_r = 1
export (float) var max_r = 8

var enemy_a : Spatial
var enemy_b : Spatial

func _ready():
	enemy_a = enemy_scene.instance()
	enemy_b = enemy_scene.instance()
	enemy_a.translate(get_random_enemy_position())
	enemy_b.translate(get_random_enemy_position())
	add_child(enemy_a)
	add_child(enemy_b)
	enemy_a.connect("fall", self, "_on_Enemy_fall", [enemy_a])
	enemy_b.connect("fall", self, "_on_Enemy_fall", [enemy_b])
	

func _physics_process(_delta) -> void:
	enemy_a.target = enemy_b.rigid_body.global_transform.origin + enemy_b.rigid_body.linear_velocity.normalized() * 2.0
	enemy_b.target = enemy_a.rigid_body.global_transform.origin + enemy_a.rigid_body.linear_velocity.normalized() * 4.0


func get_random_enemy_position() -> Vector3:
	var theta : float = randf() * 2.0 * PI
	var r : float = randf() * (max_r - min_r) + min_r
	return Vector3(
		cos(theta) * r,
		0,
		sin(theta) * r
	)

func _on_Enemy_fall(enemy) -> void:
	enemy.is_dead = false
	enemy.translation = get_random_enemy_position()
	enemy.rigid_body.translation = Vector3(0, 2, 0)
	enemy.rigid_body.linear_velocity = Vector3(0, 0, 0)
	enemy.rigid_body.angular_velocity = Vector3(0, 0, 0)
