extends KinematicBody2D

var Bullet = preload("res://Bullet.tscn")
onready var Ui = get_node("/root/Ai/CanvasLayer/UI")
onready var player = get_tree().get_current_scene().get_node("Player")
var KillPickup = preload("res://Power-Ups/KillPickup.tscn")

var time : int = 0

var targets : Array = []
var target : Vector2
var posible_targets : Array = []
var num : int = 0
var health : int = 4
var max_health : int = 4
var can_play_anim : bool = true
var minimap_icon = "EnemyDot"
var dead : bool = false
var score : int = 0

func _ready():
	if Autoload.is_mainscene == true:
		for node in get_tree().get_nodes_in_group("targets"):
			if node != self:
				targets.append(node)

func spawn_bullet(target):
	var bullet = Bullet.instance()
	bullet.position = position
	bullet.rotation = rotation
	bullet.target = target
	bullet.p_name = self.name
	bullet.parent = self
	get_parent().add_child(bullet)
	
func hit():
	if can_play_anim:
		can_play_anim = false
		var tween = Tween.new()
		add_child(tween)
		
		# Interpolate the scale property over 0.2 seconds
		tween.interpolate_property($SquareSprite, "scale", $SquareSprite.scale, $SquareSprite.scale * 1.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.interpolate_property($SquareSprite, "scale", $SquareSprite.scale * 1.5, $SquareSprite.scale, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.connect("tween_completed", self, "on_hit_tween_complete")
		# Start the tween
		tween.start()
	else:
		yield(get_tree().create_timer(1), "timeout")
		can_play_anim = true

func on_hit_tween_complete(a, b):
	can_play_anim = true

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

	move_and_slide(direction * 200)

	# rotate the enemy to face the player
	var angle = direction.angle_to(Vector2(1, 0))
	rotation = -angle + 89.525

	time += 1

	# if the enemy is close enough to the player, kill the player
	if distance < 1000 and time > 50 and Autoload.is_mainscene == true:
		spawn_bullet(target)
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
		
		time = 0

	if Autoload.is_mainscene == false and time > 50:
		spawn_bullet(target)
		for t in targets:
			target = t.position
			print(t.name)
		time = 0

	if health <= 0:
		die()

func die():
	dead = true
	$Player_Trail.hide()
	var tween = Tween.new()
	tween.interpolate_property(self, "scale", self.scale, Vector2(0, 0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	add_child(tween)
	tween.connect("tween_completed", self, "on_tween_complete")
	tween.start()
	yield(get_tree().create_timer(0.5), "timeout")
	for bullet in get_children():
		bullet.queue_free()
	# spawn a new square enemy
	Autoload.spawn_enemy("square")
	# spawn the kill pickup
	var kill_pickup = KillPickup.instance()
	kill_pickup.position = position
	get_parent().add_child(kill_pickup)

	queue_free()
