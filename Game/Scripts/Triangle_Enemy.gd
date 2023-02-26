extends KinematicBody2D

var Bullet = preload("res://Bullet.tscn")
onready var Ui = get_node("/root/Ai/CanvasLayer/UI")

var time : int = 0

var targets : Array = []
var target : Vector2
var posible_targets : Array = []
var num : int = 0
var health : int = 3
var max_health : int = 3

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
	
func hit():
	var tween = Tween.new()
	add_child(tween)
	
	# Interpolate the scale property over 0.2 seconds
	tween.interpolate_property($TriangleSprite, "scale", $TriangleSprite.scale, $TriangleSprite.scale * 1.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property($TriangleSprite, "scale", $TriangleSprite.scale * 1.5, $TriangleSprite.scale, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	# Start the tween
	tween.start()

func _process(delta):

	targets = []

	for node in get_tree().get_nodes_in_group("targets"):
		if node != self:
			targets.append(node)

	# using if statement check for error
	if target == null or Vector2(0,0) or target.length() == 0:
		targets.shuffle()
		for t in targets:
			posible_targets.append(t)
			num = rand_range(0, posible_targets.size())
			if is_instance_valid(posible_targets[num]):
				target = posible_targets[num].position
				posible_targets = []
			else:
				targets.remove(posible_targets[num])
				posible_targets = []
				
	else:
		pass

	#print(target)
	
	var direction = target - position
	var distance = direction.length()
	direction = direction.normalized()

	position += direction * 200 * delta

	# rotate the enemy to face the player
	var angle = direction.angle_to(Vector2(1, 0))
	rotation = -angle + 89.525

	time += 1

	# if the enemy is close enough to the player, kill the player
	if distance < 1000:
		# using if statement check for error
		targets.shuffle()
		for t in targets:
			posible_targets.append(t)
			num = rand_range(0, posible_targets.size())
			if is_instance_valid(posible_targets[num]):
				target = posible_targets[num].position
				posible_targets = []
			else:
				targets.remove(posible_targets[num])
				posible_targets = []
		
	if time >= 40:
		# spawn a bullet in the direction that the enemy is facing
		spawn_bullet(target)
		time = 0

	if health <= 0:
		die()

func die():
	$Player_Trail.hide()
	var tween = Tween.new()
	tween.interpolate_property(self, "scale", self.scale, Vector2(0, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	add_child(tween)
	tween.start()
	yield(get_tree().create_timer(2.0), "timeout")
	on_tween_complete()

func on_tween_complete():
	if "targets" in get_groups():
		remove_from_group("targets")
	get_parent().total_enemys -= 1
	print("Total enemys: " + str(get_parent().total_enemys))
	Ui.update_players(get_parent().total_enemys)
	print("DED")
	queue_free()