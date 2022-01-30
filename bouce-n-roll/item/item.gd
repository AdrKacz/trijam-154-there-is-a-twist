extends Area
signal hit(by)


export (float) var rotation_speed : float = 5


# Called when the node enters the scene tree for the first time.
func _ready():
	respawn()
	
func respawn():
	var theta : float = randf() * PI * 2
	var r : float = randf() * 5 + 1
	
	translation = Vector3(
		r * cos(theta),
		2,
		r * sin(theta)
	)
	GameGlobal.item_translation = translation


func _process(delta):
	rotate(Vector3.UP, delta * rotation_speed)


func _on_Item_body_entered(body) -> void:
	emit_signal("hit", body.get_groups())
	respawn()
