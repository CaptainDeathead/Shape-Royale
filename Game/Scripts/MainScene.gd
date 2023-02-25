extends Node2D

onready var enemy = preload("res://Enemys/Square_Enemy.tscn")

var total_enemys = 100

func _ready():
	var enemy_instance = enemy.instance()
	$Square_Player.position = Vector2(rand_range(-2500, 2500), rand_range(-2500, 2500))
	for i in range(20):
		# spawn 99 enemies in random positions
		enemy_instance = enemy.instance()
		add_child(enemy_instance)
		enemy_instance.position = Vector2(rand_range(-2500, 2500), rand_range(-2500, 2500))
		enemy_instance.name = "Enemy" + str(i)
		# add the enemy to targets group
		enemy_instance.add_to_group("targets")
