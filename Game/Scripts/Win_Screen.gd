extends Control

func _on_PlayAgainButton_pressed():
	get_tree().change_scene("res://Scenes/Ai.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Main_Menu.tscn")
