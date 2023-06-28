extends Node

var main_character : character
var scanned_characters : Array[character]
const SAVE_PATH := "user://characters/main_character.tres"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scan_characters()
	var dir = DirAccess.open("user://")
	if !dir.dir_exists("characters"):
		dir.make_dir("characters")
	if ResourceLoader.exists(SAVE_PATH):
		load_save_character()
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
	var error = ResourceSaver.save(main_character, SAVE_PATH)
	if error != OK:
		print("Not saved")
	pass

func load_save_character():
	main_character = ResourceLoader.load(SAVE_PATH).duplicate(true)
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
			if final_name == main_character.last_save_path:
				break
			counter += 1
		else:
			break
	return final_name
	pass

func scan_characters():
	scanned_characters.clear()
	var dir = DirAccess.open("user://characters")
	var all_files = dir.get_files()
	for file in all_files:
		var loaded_character = ResourceLoader.load(SAVE_PATH).duplicate(true)
		if loaded_character != null:
			scanned_characters.append(loaded_character)
	pass
