extends Area2D

func _on_Flag_body_entered(body):
	if body.name == "Player":
		Autoload.level += 1
		Autoload.game_data["level"] = Autoload.level
		Autoload.save_data()
		Autoload.load_data()
