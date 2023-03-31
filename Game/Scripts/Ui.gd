extends Control

onready var txrect = get_node("TextureRect")
onready var healthbar = txrect.get_node("HealthBar")

func update_players(players):
	var label = $PlayersLabel
	label.text = "Alive Players: " + str(players)

func update_enemy(enemy):
	enemy = round(enemy)
	$EnemyLabel.text = "Closest Enemy: " + str(enemy) + "m"

func set_enemy_direction(enemy_rotation: Vector2):
	# Get angle from player to enemy
	var angle = atan2(enemy_rotation.y, enemy_rotation.x)

	# Convert angle to a unit vector
	var direction = Vector2(cos(angle), sin(angle))

	# Determine how far to move arrow towards edge of screen
	var arrow_distance = 100 # Change this value to adjust arrow distance from screen edge
	var screen_size = get_viewport_rect().size
	var screen_center = screen_size / 2
	var edge_offset = screen_center / 2.75
	var target_position = screen_center + direction * (screen_center.x - edge_offset.x - arrow_distance)

	# Move arrow to target position
	$Arrow.position = target_position
	$Arrow.rotation = angle - PI / 2 + PI

func _ready():
	healthbar.modulate = Color(0, 1, 0)
	if Autoload.is_mobile == true:
		$QuitButton.show()

func update_health(health, max_health):
	healthbar.value = int(float(health) / max_health * 100)
	if health == max_health:
		healthbar.modulate = Color(0, 1, 0)
	if health <= max_health / 2:
		healthbar.modulate = Color(1, 1, 0)
	if health <= max_health / 4:
		healthbar.modulate = Color(1, 0, 0)

func _on_QuitButton_pressed():
	get_tree().change_scene("res://Main_Menu.tscn")

func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)
