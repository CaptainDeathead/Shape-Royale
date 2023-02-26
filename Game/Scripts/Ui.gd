extends Control

func update_players(players):
	var label = $PlayersLabel
	label.text = "Alive Players: " + str(players)

func _ready():
	$HealthBar.modulate = Color(0, 1, 0)

func update_health(health, max_health):
	$HealthBar.value = int(float(health) / max_health * 100)
	if health <= max_health / 2:
		$HealthBar.modulate = Color(1, 1, 0)
	if health <= max_health / 4:
		$HealthBar.modulate = Color(1, 0, 0)
