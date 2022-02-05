extends Spatial

signal enemy_fall

export (PackedScene) var enemy_scene : PackedScene
export (float) var min_r = 1
export (float) var max_r = 8

func spawn_enemies(n : int):
	for i in range(n):
		spawn_enemy()

func spawn_enemy():
	var theta : float = randf() * 2 * PI
	var r : float = randf() * (max_r - min_r) + min_r
	
	# TODO: check for collision
	var enemy : Spatial = enemy_scene.instance()
	enemy.translate(Vector3(
		cos(theta) * r,
		0,
		sin(theta) * r
	))
	enemy.connect("fall", self, "_on_Enemy_fall")
	add_child(enemy)
	
func update_target_all(target):
	for enemy in get_children():
		enemy.target = target
		
func _on_Enemy_fall() -> void:
	emit_signal("enemy_fall")
	
