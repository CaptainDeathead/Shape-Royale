extends Node2D

onready var Square_Enemy = preload("res://Enemys/Square_Enemy.tscn")
onready var Circle_Enemy = preload("res://Enemys/Circle_Enemy.tscn")
onready var Triangle_Enemy = preload("res://Enemys/Triangle_Enemy.tscn")
onready var health = preload("res://Power-Ups/Health_Powerup.tscn")
onready var Square_Player = preload("res://Players/Square_Player.tscn")
onready var Circle_Player = preload("res://Players/Circle_Player.tscn")
onready var Triangle_Player = preload("res://Players/Triangle_Player.tscn")
onready var Ui = get_node("/root/Ai/CanvasLayer/UI")

var total_enemys = 100
var killed_targets = []

func _ready():
	Autoload.is_mainscene = true

	Ui.get_node("PlayersLabel").show()
	Ui.get_node("Arrow").show()

	var square_enemy_instance = Square_Enemy.instance()
	var circle_enemy_instance = Circle_Enemy.instance()
	var triangle_enemy_instance = Triangle_Enemy.instance()

	var total_enemys = 100
	var squares = randi() % 50 + 1
	var circles = randi() % (total_enemys - squares)
	var triangles = total_enemys - squares - circles
	for i in range(squares):
		# spawn 99 enemies in random positions
		square_enemy_instance = Square_Enemy.instance()
		add_child(square_enemy_instance)
		square_enemy_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		square_enemy_instance.name = "Enemy"
		# add the enemy to targets group
		square_enemy_instance.add_to_group("targets")
		square_enemy_instance.add_to_group("enemies")
	for i in range(circles):
		# spawn 99 enemies in random positions
		circle_enemy_instance = Circle_Enemy.instance()
		add_child(circle_enemy_instance)
		circle_enemy_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		circle_enemy_instance.name = "Enemy"
		# add the enemy to targets group
		circle_enemy_instance.add_to_group("targets")
		circle_enemy_instance.add_to_group("enemies")
	for i in range(triangles):
		# spawn 99 enemies in random positions
		triangle_enemy_instance = Triangle_Enemy.instance()
		add_child(triangle_enemy_instance)
		triangle_enemy_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		triangle_enemy_instance.name = "Enemy"
		# add the enemy to targets group
		triangle_enemy_instance.add_to_group("targets")
		triangle_enemy_instance.add_to_group("enemies")

	var health_instance = health.instance()
	for i in range(35):
		# spawn 25 health powerups in random positions
		health_instance = health.instance()
		add_child(health_instance)
		health_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		health_instance.name = "Health"
		# add the health powerup to powerups group
		health_instance.add_to_group("powerups")

	if Autoload.current_player == "Square":
		var player_instance = Square_Player.instance()
		add_child(player_instance)
		player_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		player_instance.name = "Player"
		player_instance.add_to_group("targets")
	elif Autoload.current_player == "Circle":
		var player_instance = Circle_Player.instance()
		add_child(player_instance)
		player_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		player_instance.name = "Player"
		player_instance.add_to_group("targets")
	elif Autoload.current_player == "Triangle":
		var player_instance = Triangle_Player.instance()
		add_child(player_instance)
		player_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		player_instance.name = "Player"
		player_instance.add_to_group("targets")
	else:
		var player_instance = Square_Player.instance()
		add_child(player_instance)
		player_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		player_instance.name = "Player"
		player_instance.add_to_group("targets")

	print(Autoload.current_player)

func _process(delta):
	if total_enemys <= 1:
		yield(get_tree().create_timer(2), "timeout")
		get_tree().change_scene("res://Scenes/Win_Screen.tscn")

	var closest_distance = 99999999
	var closest_enemy = null
	
	for target in get_tree().get_nodes_in_group("targets"):
		if target.name == "Player":
			continue
		var distance = target.position.distance_to($Player.position)
		if distance < closest_distance:
			closest_distance = distance
			closest_enemy = target
			Ui.update_enemy(closest_distance / 8)

			# Calculate direction vector
			var direction = closest_enemy.position - $Player.position
			direction = direction.normalized()
			
			Ui.set_enemy_direction(direction)

	total_enemys = 0
	for target in get_tree().get_nodes_in_group("targets"):
			total_enemys += 1

	Ui.update_enemy(total_enemys)

	$Camera2D.position.x = $Player.position.x
	$Camera2D.position.y = $Player.position.y
