extends editing_line

@export var all_params      : VBoxContainer
@export var base_boxes      : HBoxContainer
@export var params_boxes    : HBoxContainer
@export var settings_button : TextureButton

@export var all_buttons    : Control

@onready var stress_box_class    = preload("res://entities/stress_box.tscn")
@onready var stress_term_class = preload("res://entities/params.tscn")

var box_counts : int
var edit_mode  := false
var my_params : stress_counter

func _ready() -> void:
	
	pass

func new_params():
	my_params  = stress_counter.new()
	box_counts = my_params.boxes.size()
	update_boxes()
	pass

func set_params(new_params : stress_counter):
	my_params  = new_params
	box_counts = my_params.boxes.size()
	update_boxes()
	pass

func select(flag):
	super.select(flag)
	all_buttons.modulate = Color.WHITE if flag else Color.TRANSPARENT 
	pass


func add_params() -> void:
	var new_params = stress_term_class.instantiate()
	all_params.add_child(new_params)
	pass # Replace with function body.


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
	for term in my_params.terms:
		term = term as stress_term
		var box = term.final_box as stress_box
		var new_box = stress_box_class.instantiate()
		base_boxes.add_child(new_box)
		new_box.set_params(box)
#		new_box.edit_mode_flag = edit_mode
	pass

func _on_set_new_text():
	my_params.name = line_label.text
	pass # Replace with function body.
