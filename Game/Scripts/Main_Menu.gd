extends Control

func _on_Ai_pressed():
	get_tree().change_scene("res://Scenes/Ai.tscn")

func _on_Quit_pressed():
	# load the index.html file
	var url = OS.get_executable_path().get_base_dir().plus_file("index.html")
	OS.shell_open(url)
	get_tree().quit()

var players = ["Square", "Triangle", "Circle"]
var current_player = players[0]
var current_player_index = 0
onready var parent = get_node("Selection_label")
onready var preview_sprite = parent.get_node("PreviewSprite")
onready var shape_label = parent.get_node("ShapeLabel")
onready var player_description = parent.get_node("StatsLabel")

func _on_Left_pressed():
	current_player_index = (current_player_index - 1) % len(players)
	current_player = players[current_player_index]
	update_player_description()


func _on_Right_pressed():
	current_player_index = (current_player_index + 1) % len(players)
	current_player = players[current_player_index]
	update_player_description()

func update_player_description():
	match current_player:
		"Square":
			preview_sprite.texture = preload("res://Sprites/Square_Sprite_Player.png")
			shape_label.text = "Square"
			player_description.text = "Health: 4 Hits\nRate of Fire: 1 Shot Per 0.5 Seconds\nSpeed: Normal"
		"Triangle":
			preview_sprite.texture = preload("res://Sprites/Triangle_Sprite_Player.png")
			shape_label.text = "Triangle"
			player_description.text = "Health: 3 Hits\nRate of Fire: Rapid (1 Shots/0.4 Sec)\nSpeed: Fast"
		"Circle":
			preview_sprite.texture = preload("res://Sprites/Circle_Sprite_Player.png")
			shape_label.text = "Circle"
			player_description.text = "Health: 6 Hits\nRate of Fire: 1 Shot Per 0.75 Seconds\nSpeed: Slow"

	Autoload.current_player = current_player


func _on_Continue_pressed():
	Autoload.load_data()


func _on_New_pressed():
	Autoload.level = 1
	Autoload.game_data["level"] = Autoload.level
	Autoload.save_data()
	Autoload.load_data()
