extends Node

const SAVEGAME = "user://Savegame.json"

var save_data = {}

func _ready():
	save_data = get_data()
	if save_data.has("Player_name"):
		pass
	else:
		save_data = {"Player_name": "Unnamed"}
		save_game()

func get_data():
	var file = File.new()

	if not file.file_exists(SAVEGAME):
		save_data = {}
		print("No savegame found, creating new one")
		save_game()
	else:
		file.open(SAVEGAME, File.READ)
		var content = file.get_as_text()
		var parse_result = JSON.parse(content)
		if parse_result.error != OK:
			print("Error parsing JSON:", parse_result.error)
			save_data = {}
			save_game()
		else:
			save_data = parse_result.result

		file.close()

		print(save_data)

	return save_data

func save_game():
	var save_game = File.new()
	save_game.open(SAVEGAME, File.WRITE)
	save_game.store_line(to_json(save_data))
	save_game.close()
