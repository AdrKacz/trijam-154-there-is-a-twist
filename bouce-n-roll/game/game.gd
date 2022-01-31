extends Spatial


func _physics_process(_delta):
	$Enemy.target = $Controller.translation + $Controller.rigid_body.translation
