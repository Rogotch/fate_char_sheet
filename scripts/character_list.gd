extends Control
@export var actions_descriptions          : ScrollContainer
@export var skills                        : VBoxContainer
@export var bar                           : Control
@export var roller                        : VBoxContainer
@export var stresses                      : VBoxContainer
@export var skills_container              : Container
@export var character_name                : HBoxContainer
@export var scroll_parameters             : ScrollContainer
@export var parameters_holder             : HBoxContainer

@export var aspects_holder     : VBoxContainer
@export var stunts_holder      : VBoxContainer
@export var stresses_holder    : VBoxContainer

@onready var aspect_class = preload("res://entities/aspect_line.tscn")
@onready var stress_class = preload("res://entities/stress_counter.tscn")
@onready var stunt_class  = preload("res://entities/stunt.tscn")


var roll_result := 0
var selecting_skill : skill

func _ready() -> void:
	if CharactersSystem.main_character == null: 
		CharactersSystem.new_character()
	character_name.set_new_text.connect(set_character_name)
	full_load()
	pass

func set_character_name():
	var char = CharactersSystem.main_character as character
	char.name = character_name.get_text()
	print_debug(char.name.is_valid_filename(), " ", char.name.validate_filename())
	pass

func load_character_name():
	var char = CharactersSystem.main_character as character
	character_name.set_text(char.name)
	
	pass

func _on_bar_result(value) -> void:
	actions_descriptions.action_result(value)
	pass # Replace with function body.

func _on_roller_roll(value) -> void:
	roll_result = value
	set_bar_value()
	pass # Replace with function body.

func _on_skills_select_skill(skill_data : skill) -> void:
	selecting_skill = skill_data
	roller.set_skill(skill_data.value)
	set_bar_value()
	pass # Replace with function body.

func set_bar_value():
	var skill_value = selecting_skill.value if selecting_skill != null else 0
	bar.set_value(skill_value + roll_result, true)
	pass

func add_skill() -> void:
	skills_container.add_skill("Навык", 0)
	pass # Replace with function body.

func add_new_stress() -> void:
	var char = CharactersSystem.main_character as character
	var new_stress_data = stress_counter.new()
	char.stresses.append(new_stress_data)
	_add_entity(new_stress_data, stress_class, stresses_holder)
#	add_stress(new_stress_data)
	pass # Replace with function body.

func add_new_stunt() -> void:
	var char = CharactersSystem.main_character as character
	var new_stunt_data = stunt.new()
	char.stunts.append(new_stunt_data)
	_add_entity(new_stunt_data, stunt_class, stunts_holder)
	pass # Replace with function body.

func add_new_aspect() -> void:
	var char = CharactersSystem.main_character as character
	var new_aspect_data = aspect.new()
	char.aspects.append(new_aspect_data)
	_add_entity(new_aspect_data, aspect_class, aspects_holder)
	pass # Replace with function body.

func _add_entity(entity_data : Resource, entity_class : PackedScene, holder : Container):
	var new_entity = entity_class.instantiate()
	holder.add_child(new_entity)
	
	new_entity.set_params(entity_data)
	new_entity.update()
	pass

func load_skills():
	Global.delete_children(skills_container)
	var char = CharactersSystem.main_character as character
	for loaded_skill in char.skills:
		loaded_skill = loaded_skill as skill
		skills_container.load_skill(loaded_skill)
	pass

func load_stresses() -> void:
	Global.delete_children(stresses_holder)
	var char = CharactersSystem.main_character as character
	for loaded_stress in char.stresses:
		loaded_stress = loaded_stress as stress_counter
		_add_entity(loaded_stress, stress_class, stresses_holder)
	pass

func load_stunts() -> void:
	Global.delete_children(stunts_holder)
	var char = CharactersSystem.main_character as character
	for loaded_stunts in char.stunts:
		loaded_stunts = loaded_stunts as stunt
		_add_entity(loaded_stunts, stunt_class, stunts_holder)
	pass

func load_aspects() -> void:
	Global.delete_children(aspects_holder)
	var char = CharactersSystem.main_character as character
	for loaded_aspect in char.aspects:
		loaded_aspect = loaded_aspect as aspect
		_add_entity(loaded_aspect, aspect_class, aspects_holder)
	pass


func _on_save_pressed() -> void:
	CharactersSystem.write_save_character()
	pass # Replace with function body.

func full_load():
	load_character_name()
	load_aspects()
	load_skills()
	load_stresses()
	load_stunts()
	pass


func _on_load_pressed() -> void:
	CharactersSystem.load_save_character()
	full_load.call_deferred()
	pass # Replace with function body.


func _on_scroll_parameters_resized() -> void:
	for child in parameters_holder.get_children():
		child = child as Control
		child.custom_minimum_size.x = scroll_parameters.size.x - 2
	pass # Replace with function body.

func set_tab(tab_num : int):
	scroll_parameters.scroll_horizontal = scroll_parameters.size.x * tab_num
	pass
