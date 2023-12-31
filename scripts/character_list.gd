extends Control
@export_group("", "")
@export var add_character_icon : Texture2D

@export_group("Nodes")
@export var actions_descriptions          : ScrollContainer
@export var skills                        : VBoxContainer
@export var bar                           : Control
@export var roller                        : VBoxContainer
@export var stresses                      : VBoxContainer
@export var skills_container              : Container
@export var character_name                : HBoxContainer
@export var scroll_parameters             : ScrollContainer
@export var parameters_holder             : HBoxContainer
@export var concept                       : HBoxContainer
@export var main_stress                   : VBoxContainer
@export var fate_points_ui                : VBoxContainer
@export var history                       : VBoxContainer
@export var portrait                      : TextureRect
@export var file_dialog                   : FileDialog
@export var popup                         : PopupMenu
@export var select_button                 : TextureButton

@export_group("Holders")
@export var aspects_holder     : VBoxContainer
@export var stunts_holder      : VBoxContainer
@export var stresses_holder    : VBoxContainer
@export var consequence_holder : VBoxContainer
@export var notes_holder       : VBoxContainer

@onready var aspect_class        = preload("res://entities/aspect_line.tscn")
@onready var stress_class        = preload("res://entities/stress_counter.tscn")
@onready var stunt_class         = preload("res://entities/stunt.tscn")
@onready var consenqunce_class   = preload("res://entities/consequence.tscn")
@onready var notes_class         = preload("res://entities/note.tscn")

var roll_result := 0
var selecting_skill : skill

func _ready() -> void:
	character_name.set_new_text.connect(set_character_name)
	SignalsBus.reload_character.connect(try_load_character)
	try_load_character()
	pass

func try_load_character():
	if CharactersSystem.main_character != null: 
		full_load()
	pass

func set_character_name():
	if CharactersSystem.main_character == null:
		return
	var _character = CharactersSystem.main_character as character
	_character.name = character_name.get_text()
#	print_debug(_character.name.is_valid_filename(), " ", _character.name.validate_filename())
	CharactersSystem.write_save_character.call_deferred()
	pass

func load_character_name():
	var _character = CharactersSystem.main_character as character
	character_name.set_text(_character.name)
	
	pass

func _on_bar_result(value) -> void:
	actions_descriptions.action_result(value)
	pass # Replace with function body.


func _on_skills_select_skill(skill_data : skill) -> void:
	selecting_skill = skill_data
	roller.set_skill(skill_data)
	set_bar_value()
	pass # Replace with function body.

func _on_skills_deselect_skill() -> void:
	selecting_skill = null
	roller.set_skill(null)
	set_bar_value()
	pass # Replace with function body.

func set_bar_value():
#	if CharactersSystem.main_character == null:
#		return
	var skill_value = selecting_skill.value if selecting_skill != null else 0
	bar.set_value(skill_value + roll_result, true)
	pass

func add_skill() -> void:
	if CharactersSystem.main_character == null:
		return
	skills_container.add_skill(tr("SKILL_BASE_NAME"), 0)
	CharactersSystem.write_save_character.call_deferred()
	pass # Replace with function body.

func add_new_stress() -> void:
	if CharactersSystem.main_character == null:
		return
	var _character = CharactersSystem.main_character as character
	var new_stress_data = stress_counter.new()
	_character.stresses.append(new_stress_data)
	_add_entity(new_stress_data, stress_class, stresses_holder)
	CharactersSystem.write_save_character.call_deferred()
#	add_stress(new_stress_data)
	pass # Replace with function body.

func add_new_stunt() -> void:
	if CharactersSystem.main_character == null:
		return
	var _character = CharactersSystem.main_character as character
	var new_stunt_data = stunt.new()
	_character.stunts.append(new_stunt_data)
	_add_entity(new_stunt_data, stunt_class, stunts_holder)
	CharactersSystem.write_save_character.call_deferred()
	pass # Replace with function body.

func add_new_aspect() -> void:
	if CharactersSystem.main_character == null:
		return
	var _character = CharactersSystem.main_character as character
	var new_aspect_data = aspect.new()
	_character.aspects.append(new_aspect_data)
	_add_entity(new_aspect_data, aspect_class, aspects_holder)
	CharactersSystem.write_save_character.call_deferred()
	pass # Replace with function body.

func add_new_consenqunce() -> void:
	if CharactersSystem.main_character == null:
		return
	var _character = CharactersSystem.main_character as character
	var new_consequence_data = consequence.new()
	_character.consequences.append(new_consequence_data)
	_add_entity(new_consequence_data, consenqunce_class, consequence_holder)
	CharactersSystem.write_save_character.call_deferred()
	pass # Replace with function body.

func add_new_note() -> void:
	if CharactersSystem.main_character == null:
		return
	_add_note("")
	CharactersSystem.write_save_character.call_deferred()
	pass

func _add_note(text : String):
	if CharactersSystem.main_character == null:
		return
	var note = notes_class.instantiate()
	notes_holder.add_child(note)
	
	note.set_params(text)
	note.update()
	pass

func _add_entity(entity_data : Resource, entity_class : PackedScene, holder : Container):
	var new_entity = entity_class.instantiate()
	holder.add_child(new_entity)
	
	new_entity.set_params(entity_data)
	new_entity.update()
	pass

#func delete_entity(params : Resource, character_holder : Array):
#	pass

func load_skills():
	Global.delete_children(skills_container)
	var _character = CharactersSystem.main_character as character
	for loaded_skill in _character.skills:
		loaded_skill = loaded_skill as skill
		skills_container.load_skill(loaded_skill)
	pass

func load_stresses() -> void:
	Global.delete_children(stresses_holder)
	var _character = CharactersSystem.main_character as character
	for loaded_stress in _character.stresses:
		loaded_stress = loaded_stress as stress_counter
		if loaded_stress.main:
			select_main_stress(loaded_stress)
		_add_entity(loaded_stress, stress_class, stresses_holder)
	pass

func load_stunts() -> void:
	Global.delete_children(stunts_holder)
	var _character = CharactersSystem.main_character as character
	for loaded_stunts in _character.stunts:
		loaded_stunts = loaded_stunts as stunt
		_add_entity(loaded_stunts, stunt_class, stunts_holder)
	pass

func load_aspects() -> void:
	Global.delete_children(aspects_holder)
	var _character = CharactersSystem.main_character as character
	for loaded_aspect in _character.aspects:
		loaded_aspect = loaded_aspect as aspect
		if loaded_aspect.main:
			select_main_aspect(loaded_aspect)
		_add_entity(loaded_aspect, aspect_class, aspects_holder)
	pass

func load_consenqunces() -> void:
	Global.delete_children(consequence_holder)
	var _character = CharactersSystem.main_character as character
	for loaded_consequence in _character.consequences:
		loaded_consequence = loaded_consequence as consequence
		_add_entity(loaded_consequence, consenqunce_class, consequence_holder)
	pass

func load_points():
	var _character = CharactersSystem.main_character as character
	fate_points_ui.set_params(_character.points)
	pass

func load_notes():
	Global.delete_children(notes_holder)
	var _character = CharactersSystem.main_character as character
	for loaded_note in _character.notes:
		_add_note.call_deferred(loaded_note)
	pass

func _on_save_pressed() -> void:
	CharactersSystem.write_save_character.call_deferred()
	pass # Replace with function body.

func full_load():
	var main_character = CharactersSystem.main_character as character
	main_character.new_main_aspect.connect(select_main_aspect)
	main_character.new_main_stress.connect(select_main_stress)
	load_character_name()
	load_aspects()
	load_skills.call_deferred()
	load_stresses()
	load_stunts()
	load_consenqunces()
	load_points()
	load_notes()
	load_portrait()
	pass


func _on_load_pressed() -> void:
#	CharactersSystem.load_save_character()
#	full_load.call_deferred()
	pass # Replace with function body.


func _on_scroll_parameters_resized() -> void:
	for child in parameters_holder.get_children():
		child = child as Control
		child.custom_minimum_size.x = scroll_parameters.size.x - 2
	pass # Replace with function body.

func set_tab(tab_num : int):
	scroll_parameters.scroll_horizontal = scroll_parameters.size.x * tab_num
	pass

func select_main_aspect(selected_aspect : aspect):
	concept.set_params(selected_aspect)
	concept.update()
	pass

func select_main_stress(selected_stress : stress_counter):
	main_stress.set_params(selected_stress)
	main_stress.update()
	pass


func _on_roller_roll(skill_data : skill, value : int) -> void:
	roll_result = value
	
	var final_skill_value = 0 if skill_data == null else skill_data.value
	var skill_line = 0 if skill_data == null else skill_data.name + "(%d)" % skill_data.value
	var final_line = "{roll} + {skill} = {result}".format({"roll" : roll_result, "skill" : skill_line, "result" : final_skill_value + roll_result})
	
	var history_line = Label.new()
	history.add_child(history_line)
	history_line.text = final_line
	history.move_child(history_line, 0)
	history_line.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
#	history.horizontal_alignment = 
	
	set_bar_value()
	pass # Replace with function body.

func load_portrait():
	if CharactersSystem.main_character.portrait != null:
		portrait.texture = CharactersSystem.main_character.portrait
	pass

func _on_file_dialog_file_selected(path: String) -> void:
	if CharactersSystem.main_character == null:
		return
	var portrait_texture = load(path)
#	var portrait = load(path).get_image()
	CharactersSystem.main_character.portrait = portrait_texture
	portrait.texture = portrait_texture
	CharactersSystem.write_save_character.call_deferred()
	pass # Replace with function body.


func _on_select_image_pressed() -> void:
	if CharactersSystem.main_character == null:
		return
	file_dialog.popup_centered.call_deferred()
	pass # Replace with function body.


func _on_change_pressed() -> void:
	CharactersSystem.scan_characters()
	popup.clear()
	var img_add_character_icon = ImageTexture.create_from_image(add_character_icon.get_image())
	img_add_character_icon.set_size_override(Vector2(32, 32))
	popup.add_icon_item(img_add_character_icon, tr("ADD_NEW_CHARACTER"))
	for _character in CharactersSystem.scanned_characters:
		var character_icon = null
		if _character.portrait != null:
			character_icon = ImageTexture.create_from_image(_character.portrait.get_image())
		if character_icon != null:
			character_icon.set_size_override(Vector2(32, 32))
		popup.add_icon_item(character_icon, _character.name)
	popup.popup(Rect2(get_global_mouse_position(), Vector2.ZERO))
	pass # Replace with function body.


func _on_popup_id_pressed(id: int) -> void:
	if id == 0:
		CharactersSystem.new_character()
	else:
		CharactersSystem.select_scanned_character(id-1)
	full_load()
#	print("select ", id-1)
	pass # Replace with function body.


func _on_select_button_mouse_entered() -> void:
	select_button.modulate = Color.WHITE
	pass # Replace with function body.


func _on_select_button_mouse_exited() -> void:
	select_button.modulate = Color.TRANSPARENT
	pass # Replace with function body.
