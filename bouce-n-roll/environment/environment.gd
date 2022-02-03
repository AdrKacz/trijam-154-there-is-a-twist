extends Spatial

signal hit(position, energy)


func _on_Obstacle_hit(position, energy):
	emit_signal("hit", position, energy)
