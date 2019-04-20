tool
extends EditorScript

var item_path = "res://items"

func _run():
	var the_json = {}
	_iterate_dir(item_path, the_json)

func _iterate_dir(path, data):
	
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				print("Folder: " + file_name)
				var new_dict = {}
				data[file_name] = new_dict
				_iterate_dir(path + "/" + file_name, new_dict)
			else:
				var string = dir.get_current_dir() + "/" + file_name
				if string.ends_with(".tscn"):
					print("File: " + string)
					data[file_name.to_lower()] = string
			file_name = dir.get_next()
	else:
		print("Invalid path")