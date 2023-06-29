extends Node

var main_character : character
var scanned_characters : Array[character]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scan_characters()
	var dir = DirAccess.open("user://")
	if !dir.dir_exists("characters"):
		dir.make_dir("characters")
#	if ResourceLoader.exists(SAVE_PATH):
#		load_save_character()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_skill_by_id(id):
	for _skill in main_character.skills:
		if _skill.id == id:
			return _skill
	pass

func new_character():
	main_character = character.new()
	pass

func write_save_character():
	if main_character == null || !not_empty_name():
		return
	var save_path = get_save_path()
	print("Save! ", save_path)
	main_character.last_save_path = save_path
	var error = ResourceSaver.save(main_character, save_path)
	if error != OK:
		print("Not saved")
	pass

func load_save_character(path : String):
	if ResourceLoader.exists(path):
		main_character = ResourceLoader.load(path).duplicate(true)
#	ResourceLoader.load_threaded_request(SAVE_PATH)
#	map_data = ResourceLoader.load_threaded_get(SAVE_PATH)
	pass

func get_save_path():
	var save_name = main_character.name.validate_filename()
	var final_name := ""
	var dir = DirAccess.open("user://characters")
	var counter = 0
	while true:
		var additional_string = "_" + str(counter) if counter > 0 else ""
		final_name = save_name + additional_string + ".tres"
		if dir.file_exists(save_name + additional_string + ".tres"):
			if get_user_folder() + final_name == main_character.last_save_path:
				break
			counter += 1
		else:
			break
	return get_user_folder() + final_name
	pass

func not_empty_name():
	return main_character.name.is_valid_filename()
	pass

func scan_characters():
	scanned_characters.clear()
	var dir = DirAccess.open("user://characters")
	var all_files = dir.get_files()
	for file in all_files:
		var full_path = get_user_folder() + file
		var loaded_character = ResourceLoader.load(full_path).duplicate(true)
		if loaded_character != null:
			scanned_characters.append(loaded_character)
	pass

func select_scanned_character(id : int):
	if scanned_characters.size() <= id:
		return
	main_character = scanned_characters[id]
	pass

func get_user_folder():
	return "user://characters/"
	pass
