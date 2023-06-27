extends editing_line

signal delete

@export var aspect_edit_line        : LineEdit
@export var aspect_type_edit_line   : LineEdit
@export var aspect_line             : Label
@export var aspect_type_line        : Label
@export var _delete_button          : TextureButton
@export var cons_stress_box         : TextureRect
@export var terms                   : VBoxContainer
@export var all_terms               : VBoxContainer

var delete_flag   := false
var edit_flag     := false
var my_params     : consequence

@onready var stress_term_class   = preload("res://entities/consequence_term.tscn")

func _ready() -> void:
	super._ready()
	SignalsBus.skills_changed.connect(update_terms)
	new_params()
	pass

func set_text_from_edit():
	set_text(aspect_edit_line.text)
	set_text_aspect_type(aspect_type_edit_line.text)
	update()
	pass

func set_params(cons_data : consequence):
	my_params = cons_data
	update()
	load_terms()
	pass

func new_params():
	my_params = consequence.new()
	my_params.stress = stress_box.new()
	cons_stress_box.set_params(my_params.stress)
	pass

func update():
	aspect_line.text             = my_params.name
	aspect_edit_line.text        = my_params.name
	aspect_type_line.text        = my_params.type
	aspect_type_edit_line.text   = my_params.type
	cons_stress_box.set_params(my_params.stress)
	update_terms()
	pass

func set_text(new_text):
	my_params.name = new_text
	emit_signal("set_new_text")
	pass

func set_text_aspect_type(new_text):
	my_params.type = new_text
	emit_signal("set_new_text")
	pass

func _on_delete_button_pressed() -> void:
	if delete_flag:
		queue_free()
	else:
		change_delete_flag(true)
	pass # Replace with function body.

func change_delete_flag(new_flag : bool):
	delete_flag = new_flag
	_delete_button.modulate = Color.WHITE if !delete_flag else Color.RED
#	delete_button.texture_normal = 
	pass

func submit_text(new_text : String):
	set_text_from_edit()
	set_edit_mod(false)
	redacted_mode = false
	pass

func set_edit_mod(flag):
	edit_flag = flag
	update_disabled_modulation(!flag)
	super.set_edit_mod(flag)
	var box = my_params.stress as stress_box
	cons_stress_box.set_params(box)
	
	_delete_button.visible = flag
	cons_stress_box.edit_mode_flag = flag
	if !flag:
		change_delete_flag(false)
	update_terms()
	pass

func update_terms():
	if my_params.terms.size() == 0:
		return
	var final_flag := false
	for term in my_params.terms:
		term = term as stress_term
		var term_skill = CharactersSystem.get_skill_by_id(term.skill_id) as skill
		final_flag = final_flag || term_skill.value >= term.skill_value
		print_debug(term_skill.value, " ", term.skill_value)
	cons_stress_box.disabled_flag = !final_flag
	if !edit_flag:
		update_disabled_modulation(!final_flag)
	pass

func update_disabled_modulation(flag : bool):
	modulate = Color.DARK_GRAY if flag else Color.WHITE
	pass

func press_button():
	super.press_button()
	terms.visible = redacted_mode
	pass

func add_params() -> void:
	var new_terms = stress_term.new()
	my_params.terms.append(new_terms)
	
	var _new_params = stress_term_class.instantiate()
	
	_new_params.set_params(new_terms)
	all_terms.add_child(_new_params)
	
	new_terms.changed.connect(update_terms)
	_new_params.box.params.changed.connect(update_terms)
	pass # Replace with function body.

func load_terms():
#	var main_character = CharactersSystem.main_character as character
	for term in my_params.terms:
		var _new_params = stress_term_class.instantiate()
		
		_new_params.set_params(term)
		all_terms.add_child(_new_params)
		term.changed.connect(update_terms)
		_new_params.deleted.connect(delete_term.bind(_new_params))
	pass

func delete_term(term_ui : Control):
	my_params.terms.erase(term_ui.params)
	pass

func _on_delete_button_delete() -> void:
	var _character = CharactersSystem.main_character as character
	_character.consequences.erase(my_params)
	delete.emit()
	queue_free()
	pass # Replace with function body.
