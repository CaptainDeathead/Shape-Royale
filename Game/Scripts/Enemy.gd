extends KinematicBody2D

onready var player = get_node("../Square_Player")
var Bullet = preload("res://Bullet.tscn")

var time : int = 0

var targets : Array = []
var target : Vector2

func _ready():
	for node in get_tree().get_nodes_in_group("targets"):
		if node != self:
			targets.append(node)

func spawn_bullet(target):
	var bullet = Bullet.instance()
	bullet.position = position
	bullet.rotation = rotation
	bullet.target = target
	bullet.p_name = self.name
	get_parent().add_child(bullet)

func _process(delta):

	# using if statement check for error
	if target == null:
		for t in targets:
			if (t.position - position).length() < 1000:
				target = t.position
	else:
		pass
	
	var direction = target - position
	var distance = direction.length()
	direction = direction.normalized()
	position += direction * 200 * delta

	# rotate the enemy to face the player
	var angle = direction.angle_to(Vector2(1, 0))
	rotation = -angle + 89.525

	time += 1

	# if the enemy is close enough to the player, kill the player
	if distance < 1000 and time > 100:
		spawn_bullet(target)
		time = 0

func die():
	# make it invisible
	set_process(false)
	set_visible(false)
	# remove it from the targets group
	if "targets" in get_groups():
		remove_from_group("targets")
	queue_free()
