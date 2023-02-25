extends Area2D

func _on_Zone_body_exited(body):
	if body.name == "Square_Player":
		body.die()
