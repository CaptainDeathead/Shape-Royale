extends Area2D


func _on_KillPickup_body_entered(body):
	if "enemy" or "player" in body.name and body.name:
		# play sound
		#
		# ----------
		# add score
		body.score += 10
		var tween = Tween.new()
		# make the sprite increase then decrease in size until it disappears
		tween.interpolate_property($Sprite, "scale", $Sprite.scale, $Sprite.scale * 1.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.interpolate_property($Sprite, "scale", $Sprite.scale, 0, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed")
		add_child(tween)
		tween.start()
		# disable collision
		$CollisionShape2D.disabled = true
	
func _on_Tween_tween_all_completed():
	# remove the sprite
	queue_free()

