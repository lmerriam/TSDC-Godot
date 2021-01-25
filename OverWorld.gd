extends Node

var activities = []
var width := 30
var height := 30

func _ready():
	_generate_overworld()

func _generate_overworld():
	var startX = randi() % width + 1
	var startY = randi() % height + 1
	for x in width:
		activities.append([])
		for y in height:
			var activity = load("res://activities/Encounter.gd").new()
			activities[x].append(activity)
			activity.x = x
			activity.y = y
			if (x >= startX - 1 and x <= startX + 1) and (y >= startY - 1 and y <= startY + 1):
				activity.revealed = true
