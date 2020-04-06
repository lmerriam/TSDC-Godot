tool
extends EditorPlugin

var fs = get_editor_interface().get_resource_filesystem()

func _enter_tree():
	print("Starting equipment watcher")
	fs.connect("filesystem_changed", self, "_on_update_libraries")

func _exit_tree():
	fs.queue_free()
	pass

func _on_update_libraries():
	print("Updating libraries")
	_generate_library(ItemLibrary.ITEM_FOLDER, ItemLibrary.ITEM_JSON)

func _generate_library(folder_path, json_path):
	
	#Create JSON
	var data = {}
	var dir = Directory.new()
	if dir.open(folder_path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
				data[file_name] = {}
				_iterate_dir(folder_path.plus_file(file_name), data[file_name])
			file_name = dir.get_next()
	else:
		print("ItemLibrary watcher: invalid path")
	dir.list_dir_end()
	to_json(data)
	
	#Save JSON
	var f = File.new()
	f.open(json_path, File.WRITE)
	f.store_string(JSON.print(data, "  ", true))
	f.close()

func _iterate_dir(path, data):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir():
#				print("Folder: " + file_name)
#				var new_dict = {}
#				data[file_name] = new_dict
				_iterate_dir(path.plus_file(file_name), data)
			else:
				var string = dir.get_current_dir().plus_file(file_name)
				if string.ends_with(".tscn"):
#					print("File: " + string)
					data[file_name.to_lower().trim_suffix(".tscn")] = string
			file_name = dir.get_next()
	else:
		print("ItemLibrary watcher: invalid path")
	dir.list_dir_end()
