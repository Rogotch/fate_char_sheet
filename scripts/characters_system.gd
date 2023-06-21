extends Node

var main_character : character
const SAVE_PATH := "user://characters/main_character.tres"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dir = DirAccess.open("user://")
	if !dir.dir_exists("characters"):
		dir.make_dir("characters")
#		print("not exist")
#	else:
#		print("exist")
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
