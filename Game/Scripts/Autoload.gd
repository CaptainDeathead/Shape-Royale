extends Node

var current_player = current_player
var level : int = 1
var is_mainscene : bool = false

const SAVE_FILE = "user://save_file.save"
var game_data = {}

func check_data():
	if game_data.level == 2:
		get_tree().change_scene("res://Scenes/Level2.tscn")
	elif game_data.level == 3:
		get_tree().change_scene("res://Scenes/Level3.tscn")
	elif game_data.level == 4:
		get_tree().change_scene("res://Scenes/Level4.tscn")
	elif game_data.level == 5:
		get_tree().change_scene("res://Scenes/Level5.tscn")
	else:
		get_tree().change_scene("res://Scenes/Level1.tscn")
		print("running")
		
	# score loading
	level = game_data.level

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()
	
func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data = {
			"level": 1
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
	check_data()
