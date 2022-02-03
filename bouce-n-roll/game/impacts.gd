extends Spatial

export (PackedScene) var impact_scene : PackedScene

func impact_at(position : Vector3, energy : float) -> void:
	var impact : Spatial = impact_scene.instance()
	impact.translate(position)
	impact.energy = energy
	add_child(impact)


func _on_Controller_hit_enemy(position, energy):
	if energy < 20:
		return
	impact_at(position, energy)

func _on_Environment_hit(position, energy):
	if energy < 20:
		return
	impact_at(position, energy)
