class_name FileUtils extends RefCounted

static func xml_to_scene_path(path):
	path = path.replace('res://addons/gmui/dist/layouts', 'res://addons/gmui/dist/scenes')
	return path.replace('.xml', '.tscn')

static func scene_to_xml_path(path):
	path = path.replace('res://addons/gmui/dist/scenes', 'res://addons/gmui/dist/layouts')
	return path.replace('.tscn', '.xml')

static func get_all_file(path:String, files:Array[String] = [])->Array[String]:
	var dirAccess:DirAccess = DirAccess.open(path)
	for file in dirAccess.get_files():
		files.append(dirAccess.get_current_dir().path_join(file))
	var dirs = dirAccess.get_directories()
	for dir in dirs:
		get_all_file(dirAccess.get_current_dir().path_join(dir), files)
	return files

static func get_all_gmui_file(path:String, except:Array[String] = [], files:Array[String] = [])->Array[String]:
	var dirAccess:DirAccess = DirAccess.open(path)
	for file in dirAccess.get_files():
		if file.get_extension() == 'gmui':
			files.append(dirAccess.get_current_dir().path_join(file))
	var dirs = dirAccess.get_directories()
	for dir in dirs:
		if except.find(dirAccess.get_current_dir()) == -1:
			get_all_gmui_file(dirAccess.get_current_dir().path_join(dir), except, files)
	return files
