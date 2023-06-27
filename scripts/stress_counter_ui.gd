extends editing_line

signal delete

@export var all_params      : VBoxContainer
@export var base_boxes      : HBoxContainer
@export var params_boxes    : HBoxContainer
@export var settings_button : TextureButton
@export var additionals     : VBoxContainer
@export var add             : TextureButton
@export var remove          : TextureButton

@export var all_buttons    : Control

@onready var stress_box_class    = preload("res://entities/stress_box.tscn")
@onready var stress_term_class   = preload("res://entities/params.tscn")

var box_counts        : int
var terms_box_counts  : int
var edit_mode         := false
var my_params         : stress_counter

func _ready() -> void:
	super._ready()
	new_params()
	SignalsBus.skills_changed.connect(update_params_boxes)
	if !editabled:
		all_buttons.visible = false
	pass

func new_params():
	my_params  = stress_counter.new()
	box_counts = my_params.boxes.size()
	my_params.changed.connect(update)
	update()
	pass

func set_params(new_params : stress_counter):
	my_params  = new_params
	box_counts = my_params.boxes.size()
	my_params.changed.connect(update)
	update()
	pass

func select(flag):
	super.select(flag)
	var final_color = Color.WHITE if flag else Color.TRANSPARENT 
	all_buttons.modulate = final_color
	add.modulate = final_color
	remove.modulate = final_color
	pass

func update():
	line_label.text = my_params.name
	update_boxes()
	update_params_boxes()
	pass

func add_params() -> void:
	var new_terms = stress_term.new()
	my_params.terms.append(new_terms)
	
	var _new_params = stress_term_class.instantiate()
	
	_new_params.set_params(new_terms)
	all_params.add_child(_new_params)
	
	new_terms.changed.connect(update_params_boxes)
	_new_params.box.params.changed.connect(update_params_boxes)
	_new_params.deleted.connect(delete_term.bind(_new_params))
	pass # Replace with function body.

func delete_term(term_ui : Control):
	my_params.terms.erase(term_ui.params)
	pass

func apply_params() -> void:
	pass # Replace with function body.

func add_box(count):
	box_counts += count
	var actual_boxes = my_params.boxes.size()
	while actual_boxes != box_counts:
		if box_counts < 0:
			break
		if actual_boxes > box_counts:
			my_params.remove_last_box()
		else:
			my_params.add_box()
		actual_boxes = my_params.boxes.size()
	update_boxes()
	pass

func change_settings():
	edit_mode = !edit_mode
	settings_button.modulate = Color.YELLOW if edit_mode else Color.WHITE
	additionals.visible = edit_mode
	for box in base_boxes.get_children():
		box.edit_mode_flag = edit_mode
	pass

func update_boxes():
	Global.delete_children(base_boxes)
	for box in my_params.boxes:
		box = box as stress_box
		var new_box = stress_box_class.instantiate()
		base_boxes.add_child(new_box)
		new_box.set_params(box)
		new_box.edit_mode_flag = edit_mode
	pass

func update_params_boxes():
	Global.delete_children(params_boxes)
#	print_debug("updated")
	for term in my_params.terms:
		term = term as stress_term
		var term_skill = CharactersSystem.get_skill_by_id(term.skill_id) as skill
		if term_skill.value >= term.skill_value:
			var box = term.final_box as stress_box
			var new_box = stress_box_class.instantiate()
			params_boxes.add_child(new_box)
			new_box.set_params(box)
			new_box.edit_mode_flag = false
#		new_box.edit_mode_flag = edit_mode
	pass

func _on_set_new_text():
	my_params.name = line_label.text
	pass # Replace with function body.


func _on_make_main_pressed() -> void:
	CharactersSystem.main_character.set_main_stress(my_params)
	pass # Replace with function body.

func _on_delete_button_delete() -> void:
	var _character = CharactersSystem.main_character as character
	_character.stresses.erase(my_params)
	delete.emit()
	queue_free()
	pass # Replace with function body.
