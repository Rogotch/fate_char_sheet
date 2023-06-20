extends Control
@export var actions_descriptions          : ScrollContainer
@export var skills                        : VBoxContainer
@export var bar                           : Control
@export var roller                        : VBoxContainer
@export var stresses                      : VBoxContainer
@export var skills_container              : Container

@export var aspects_holder     : VBoxContainer
@export var stunts_holder      : VBoxContainer
@export var stresses_holder    : VBoxContainer

@onready var aspect_class = preload("res://entities/aspect_line.tscn")
@onready var stress_class = preload("res://entities/stress_counter.tscn")
@onready var stunt_class  = preload("res://entities/stunt.tscn")


var roll_result := 0
var selecting_skill : skill

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

func add_stress() -> void:
	var char = CharactersSystem.main_character as character
	var new_stress_data = stress_counter.new()
	
	var new_stress = stress_class.instantiate()
	stresses_holder.add_child(new_stress)
	
	char.stresses.append(new_stress_data)
	new_stress.set_params(new_stress_data)
	new_stress.update()
	pass # Replace with function body.

func add_stunt() -> void:
	var char = CharactersSystem.main_character as character
	var new_stunt_data = stunt.new()

	var new_stunt = stunt_class.instantiate()
	stunts_holder.add_child(new_stunt)

	char.stunts.append(new_stunt_data)
	new_stunt.set_params(new_stunt_data)
	new_stunt.update()
	pass # Replace with function body.

func add_aspect() -> void:
	var char = CharactersSystem.main_character as character
	var new_aspect_data = aspect.new()

	var new_aspect = aspect_class.instantiate()
	stunts_holder.add_child(new_aspect)

	char.aspects.append(new_aspect_data)
	new_aspect.update()
	pass # Replace with function body.

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
	pass

func load_stunts() -> void:
	Global.delete_children(stunts_holder)
	var char = CharactersSystem.main_character as character
	for loaded_stunts in char.stunts:
		loaded_stunts = loaded_stunts as stunt
	pass

func load_aspects() -> void:
	Global.delete_children(stunts_holder)
	var char = CharactersSystem.main_character as character
	for loaded_aspect in char.aspects:
		loaded_aspect = loaded_aspect as aspect
	pass
