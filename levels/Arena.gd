extends YSort

var current_wave := 0
signal level_complete

func start_wave():
	clear_current_mobs()
	var wave = $Waves.get_child(current_wave)
	$EnemySpawner.mobs = wave.get_children()
	$EnemySpawner.start()

func clear_current_mobs():
	var mobs = $EnemySpawner/SpawnerMobList.get_children()
	for mob in mobs:
		mob.queue_free()

func _on_wave_completed():
	Global.add_announcement("Wave " + String(current_wave) +  " Complete", "")
	Global.player_entity.give_stat_points(1)
	if current_wave >= $Waves.get_child_count():
		Global.emit_signal("stage_completed")
	else:
		current_wave += 1

func _on_waveStartButton_selected(viewport, event, shape_idx):
	if event is InputEventScreenTouch or event is InputEventMouseButton and event.pressed and current_wave < $Waves.get_child_count():
		print("firing")
		start_wave()
