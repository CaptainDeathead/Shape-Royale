extends Node2D

onready var Square_Enemy = preload("res://Enemys/Square_Enemy.tscn")
onready var Circle_Enemy = preload("res://Enemys/Circle_Enemy.tscn")
onready var Triangle_Enemy = preload("res://Enemys/Triangle_Enemy.tscn")
var Square_Player = preload("res://Players/Square_Player.tscn")
var Circle_Player = preload("res://Players/Circle_Player.tscn")
var Triangle_Player = preload("res://Players/Triangle_Player.tscn")

var total_enemys = 0

func _ready():
	Autoload.is_mainscene = false

	if Autoload.current_player == "Square":
		var player_instance = Square_Player.instance()
		add_child(player_instance)
		player_instance.position = $Spawn.position
		player_instance.name = "Player"
		player_instance.add_to_group("targets")
	elif Autoload.current_player == "Circle":
		var player_instance = Circle_Player.instance()
		add_child(player_instance)
		player_instance.position = $Spawn.position
		player_instance.name = "Player"
		player_instance.add_to_group("targets")
	elif Autoload.current_player == "Triangle":
		var player_instance = Triangle_Player.instance()
		add_child(player_instance)
		player_instance.position = $Spawn.position
		player_instance.name = "Player"
		player_instance.add_to_group("targets")
	else:
		var player_instance = Square_Player.instance()
		add_child(player_instance)
		player_instance.position = $Spawn.position
		player_instance.name = "Player"
		player_instance.add_to_group("targets")

	if Autoload.level == 3 or Autoload.level == 4:
		var enemy_instance = Square_Enemy.instance()
		add_child(enemy_instance)
		enemy_instance.position = $EnemySpawn.position
		enemy_instance.name = "Enemy"
		enemy_instance.add_to_group("enemies")

	elif Autoload.level == 5 or Autoload.level == 6:
		var enemy_instance1 = Square_Enemy.instance()
		add_child(enemy_instance1)
		enemy_instance1.position = $EnemySpawn.position
		enemy_instance1.name = "Enemy"
		enemy_instance1.add_to_group("enemies")
		var enemy_instance2 = Square_Enemy.instance()
		add_child(enemy_instance2)
		enemy_instance2.position = $EnemySpawn2.position
		enemy_instance2.name = "Enemy"
		enemy_instance2.add_to_group("enemies")

func _process(delta):
	$Camera2D.position.x = $Player.position.x
	$Camera2D.position.y = $Player.position.y
