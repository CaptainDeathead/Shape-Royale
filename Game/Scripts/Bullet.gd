extends Area2D

var p_name = p_name #parent name

func _on_Bullet_body_entered(body):
	#print(body.name)
	#print(p_name)
	if body.name != p_name:
		if body.name == "Player" or "Enemy" in body.name:
			body.health -= 1
			body.hit()
			queue_free()
		else:
			queue_free()

var time : int = 0
var speed : int = 400
var vel : Vector2
var dir = Vector2(0, 0)
var target = target

func _ready():
	#print(target)
	dir = target - position
	dir = dir.normalized()

func _process(delta):
	time += 1

	if time > 5000:
		queue_free()

	if get_parent().get_node(p_name) == null:
		queue_free()

func _physics_process(delta):
	vel = dir * speed
	position += vel * delta
