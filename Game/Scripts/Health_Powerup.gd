extends Area2D

onready var mainscene = get_node("res://Scenes/MainScene.tscn")

func _on_Heath_Powerup_body_entered(body):
	if body.name == "Player" or "Enemy" in body.name:
		if body.health != body.max_health:
			body.health = body.max_health
			self.queue_free()
