extends Control

func _on_PlayAgainButton_pressed():
	if Autoload.is_mainscene == true:
		get_tree().change_scene("res://Scenes/Ai.tscn")
	else:
		get_tree().change_scene("res://Scenes/Level" + str(Autoload.level) + ".tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://Main_Menu.tscn")
	Autoload.current_player = "Square"
