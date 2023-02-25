extends KinematicBody2D

var speed : int = 200
var vel : Vector2 = Vector2(0,0)
var mouse_pos = Vector2(0,0)
var player_pos = Vector2(0,0)
var angle = 0
var dir = Vector2(0,0)
var Bullet = preload("res://Bullet.tscn")

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

	if Input.is_action_pressed("forward"):
		vel.y -= speed
	if Input.is_action_pressed("backward"):
		vel.y += speed
	if Input.is_action_pressed("left"):
		vel.x -= speed
	if Input.is_action_pressed("right"):
		vel.x += speed
	if Input.is_action_just_pressed("shoot"):
		shoot(mouse_pos)

	move_and_slide(vel)

func die():
	print("died")
	get_tree().quit()
	
