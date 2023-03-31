extends Node

var current_player = current_player
var level : int = 1
var is_mainscene : bool = false
var is_mobile = false
var shoot = false
var square_enemy = preload("res://Enemys/Square_Enemy.tscn")
var triangle_enemy = preload("res://Enemys/Triangle_Enemy.tscn")
var circle_enemy = preload("res://Enemys/Circle_Enemy.tscn")

const SAVE_FILE = "user://save_file.save"
const MOBILE_FILE = "user://mobile_file.save"
var game_data = {}
var mobile_data = {}

func check_data():
	if game_data.level == 2:
		get_tree().change_scene("res://Scenes/Level2.tscn")
	elif game_data.level == 3:
		get_tree().change_scene("res://Scenes/Level3.tscn")
	elif game_data.level == 4:
		get_tree().change_scene("res://Scenes/Level4.tscn")
	elif game_data.level == 5:
		get_tree().change_scene("res://Scenes/Level5.tscn")
	elif game_data.level == 6:
		get_tree().change_scene("res://Scenes/Level6.tscn")
	else:
		get_tree().change_scene("res://Scenes/Level1.tscn")
		print("running")
		
	# score loading
	level = game_data.level
	is_mobile = mobile_data.is_mobile

func save_data():
	var file = File.new()
	file.open(SAVE_FILE, File.WRITE)
	file.store_var(game_data)
	file.close()
	mobile_data = {"is_mobile": is_mobile}
	file = File.new()
	file.open(MOBILE_FILE, File.WRITE)
	file.store_var(mobile_data)
	file.close()
	
func load_data(status):
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		game_data = {
			"level": 1
		}
		save_data()
	file.open(SAVE_FILE, File.READ)
	game_data = file.get_var()
	file.close()
	if status == true:
		check_data()
	else:
		file = File.new()
		if not file.file_exists(MOBILE_FILE):
			mobile_data = {
				"is_mobile": false
			}
			save_data()
		mobile_data = {"is_mobile": is_mobile}
		file.open(MOBILE_FILE, File.READ)
		mobile_data = file.get_var()
		file.close()
		is_mobile = mobile_data.is_mobile

func spawn_enemy(enemy):
	if enemy == "square":
		var Enemy = square_enemy.instance()
		add_child(Enemy)
		Enemy.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
	elif enemy == "triangle":
		var Enemy = triangle_enemy.instance()
		add_child(Enemy)
		Enemy.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
	elif enemy == "circle":
		var Enemy = circle_enemy.instance()
		add_child(Enemy)
		Enemy.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))