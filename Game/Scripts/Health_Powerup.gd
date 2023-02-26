extends Area2D

onready var mainscene = get_node("res://Scenes/MainScene.tscn")

func _on_Heath_Powerup_body_entered(body):
	if body.name == "Square_Player" or "Enemy" in body.name:
		if body.health != 100:
			body.health += 100 - body.health
			self.queue_free()
