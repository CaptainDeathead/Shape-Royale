extends Area2D

func _on_Heath_Powerup_body_entered(body):
	if body.name == "Player" or "Enemy" in body.name:
		if body.health != body.max_health:
			body.health = body.max_health
			var tween = Tween.new()
			add_child(tween)

			# Interpolate the scale property over 0.2 seconds
			tween.interpolate_property($PlusSprite, "scale", $PlusSprite.scale, $PlusSprite.scale * 1.5, 0.25, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)

			# Start the tween
			tween.start()
			yield(get_tree().create_timer(0.25), "timeout")

			tween = Tween.new()
			tween.interpolate_property(self, "scale", self.scale, Vector2(0, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
			add_child(tween)
			tween.start()
			tween.connect("tween_completed", self, "on_tween_complete")

	if body.name == "Player":
		#if !ERR_DOES_NOT_EXIST:
		body.health_sound.play()
			
func on_tween_complete(a, b):
	self.queue_free()
