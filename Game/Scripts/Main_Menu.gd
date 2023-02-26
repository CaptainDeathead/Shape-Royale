extends Control

func _on_Ai_pressed():
	get_tree().change_scene("res://Scenes/ai.tscn")


func _on_Join_pressed():
	get_tree().change_scene("res://Scenes/join.tscn")


func _on_Host_pressed():
	get_tree().change_scene("res://Scenes/host.tscn")


func _on_Quit_pressed():
	get_tree().quit()
