extends Control

func update_players(players):
	var label = $PlayersLabel
	label.text = "Alive Players: " + str(players)

func _ready():
	$HealthBar.modulate = Color(0, 1, 0)

func update_health(health):
	$HealthBar.value = health
