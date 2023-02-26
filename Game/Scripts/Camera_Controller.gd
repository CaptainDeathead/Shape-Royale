extends Camera2D

onready var player = get_node("/root/Ai/Square_Player")

func _process(delta):
	# make the camera follow the player
	position.x = player.position.x
	position.y = player.position.y
