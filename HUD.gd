extends Control

func _ready():
	Global.player.connect("health_changed", self, "_on_player_health_changed")
	$HealthBar.value = 100

func _on_player_health_changed(_health, _old_health):
	$HealthBar.value = (Global.player.health / Global.player.max_health) * 100