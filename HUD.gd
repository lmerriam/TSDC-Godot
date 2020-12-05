extends Control

var announcement = preload("res://gui/Announcement.tscn")

func _ready():
	Global.player_entity.connect("health_changed", self, "_on_player_health_changed")
	$HealthBar.value = 100
	Global.connect("announcement_added", self, "_on_new_announcement_available")
	Global.add_announcement("Test1", "Test One")
	Global.add_announcement("Test2", "Test Two")

func _on_player_health_changed(_health, _old_health):
	$HealthBar.value = (Global.player_entity.health / Global.player_entity.stats["health"]) * 100

func add_announcement(primary, secondary):
	var an = announcement.instance()
	an.set_text(primary, secondary)
	$Announcements.add_child(an)
	an.set_margins_preset(Control.PRESET_WIDE)
	an.connect("tree_exited", self, "_on_announcement_complete")

func _on_new_announcement_available():
	if $Announcements.get_child_count() <= 0:
		var next = Global.pop_announcement()
		add_announcement(next.primary, next.secondary)

func _on_announcement_complete():
	var next = Global.pop_announcement()
	if next:
		add_announcement(next.primary, next.secondary)
