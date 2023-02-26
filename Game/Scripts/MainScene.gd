extends Node2D

onready var enemy = preload("res://Enemys/Square_Enemy.tscn")
onready var health = preload("res://Power-Ups/Health_Powerup.tscn")

var total_enemys = 100
var killed_targets = []

func _ready():
	var enemy_instance = enemy.instance()
	$Square_Player.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
	$Square_Player.add_to_group("targets")
	for i in range(99):
		# spawn 99 enemies in random positions
		enemy_instance = enemy.instance()
		add_child(enemy_instance)
		enemy_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		enemy_instance.name = "Enemy"
		# add the enemy to targets group
		enemy_instance.add_to_group("targets")

	var health_instance = health.instance()
	for i in range(35):
		# spawn 25 health powerups in random positions
		health_instance = health.instance()
		add_child(health_instance)
		health_instance.position = Vector2(rand_range(0, 10000), rand_range(0, 10000))
		health_instance.name = "Health"
		# add the health powerup to powerups group
		health_instance.add_to_group("powerups")

func _process(delta):
	if total_enemys <= 1:
		get_tree().change_scene("res://Scenes/Win_Screen.tscn")
