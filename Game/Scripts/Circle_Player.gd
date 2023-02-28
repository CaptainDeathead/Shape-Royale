extends KinematicBody2D

onready var Ui = get_node("/root/Ai/CanvasLayer/UI")

var speed : int = 150
var vel : Vector2 = Vector2(0,0)
var mouse_pos = Vector2(0,0)
var player_pos = Vector2(0,0)
var angle = 0
var dir = Vector2(0,0)
var Bullet = preload("res://Bullet.tscn")
var health : int = 6
var max_health = 6
var time : int = 0
var can_shoot : bool = true
var can_play_anim : bool = true

func shoot(target):
	var bullet = Bullet.instance()
	bullet.position = get_global_position()
	bullet.rotation = rotation
	bullet.target = target
	bullet.p_name = self.name
	get_parent().add_child(bullet)

func _physics_process(delta):
	vel.x = 0
	vel.y = 0
	
	# make the player turn left or right according to the mouse position
	mouse_pos = get_global_mouse_position()
	player_pos = get_global_position()
	dir = mouse_pos - player_pos
	dir = dir.normalized()
	# take 90 degrees off the angle to make the player face the mouse
	angle = dir.angle() + 1.5708
	rotation = angle
	var turn_dir = Vector2(1,0).rotated(rotation)
	var angle_degrees = rad2deg(angle)

	if Input.is_action_pressed("forward"):
		vel += dir * speed
	if Input.is_action_pressed("backward"):
		vel -= dir * speed
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot(mouse_pos + vel / 2)
		can_shoot = false
	if Input.is_action_just_pressed("escape") and $CanvasLayer.get_child(0).visible == false:
		$CanvasLayer.get_child(0).show()
	elif Input.is_action_just_pressed("escape") and $CanvasLayer.get_child(0).visible == true:
		$CanvasLayer.get_child(0).hide()

	if vel.y != 0 and vel.x != 0:
		vel /= 1.4142

	time += 1
	if time >= 75:
		can_shoot = true
		time = 0
		
	move_and_slide(vel)

func _process(delta):
	if health <= 0:
		die()
	Ui.update_health(health, max_health)

func hit():
	if can_play_anim:
		can_play_anim = false
		var tween = Tween.new()
		add_child(tween)
		
		# Interpolate the scale property over 0.2 seconds
		tween.interpolate_property($CircleSprite, "scale", $CircleSprite.scale, $CircleSprite.scale * 1.5, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.interpolate_property($CircleSprite, "scale", $CircleSprite.scale * 1.5, $CircleSprite.scale, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.connect("tween_completed", self, "on_hit_tween_complete")
		# Start the tween
		tween.start()
	else:
		yield(get_tree().create_timer(1), "timeout")
		can_play_anim = true

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
	get_tree().change_scene("res://Scenes/Lose_Screen.tscn")
	
	
func update_total_enemies(num_enemies):
	var label = $Label
	if label != null:
		label.text = "Total Players: " + str(num_enemies)


func _on_ContinueButton_pressed():
	$CanvasLayer.get_child(0).hide()

func _on_QuitButton_pressed():
	$CanvasLayer.get_child(0).hide()
	Autoload.current_player = "Square"
	get_tree().change_scene("res://Main_Menu.tscn")
