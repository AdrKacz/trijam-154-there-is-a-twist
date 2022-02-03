extends Spatial

signal hit(position, energy)

func _on_Area_body_entered(body):
	if body.is_in_group('enemy') or body.is_in_group('controller'):
		# Get Impact position and energy
		var impact_position : Vector3 = global_transform.origin + (body.global_transform.origin - global_transform.origin).normalized() * $Area/CollisionShape.shape.radius;
		var v2 : Vector3 = body.linear_velocity
		var impact_energy : float = 1.0 * v2.length_squared()
		# Alert Game
		emit_signal("hit", impact_position, impact_energy)
