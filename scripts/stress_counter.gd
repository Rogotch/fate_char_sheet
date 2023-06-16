extends editing_line

@export var all_params      : VBoxContainer
@export var base_boxes      : HBoxContainer
@export var params_boxes    : HBoxContainer
@export var settings_button : TextureButton

@export var all_buttons    : Control

@onready var stress_box_class    = preload("res://entities/stress_box.tscn")
@onready var stress_params_class = preload("res://entities/params.tscn")

var box_counts : int
var edit_mode  := false

func _ready() -> void:
	box_counts = base_boxes.get_child_count()
	pass

func select(flag):
	super.select(flag)
	all_buttons.modulate = Color.WHITE if flag else Color.TRANSPARENT 
	pass


func add_params() -> void:
	var new_params = stress_params_class.instantiate()
	all_params.add_child(new_params)
	pass # Replace with function body.


func apply_params() -> void:
	pass # Replace with function body.

func add_box(count):
	box_counts += count
	var actual_boxes = base_boxes.get_child_count()
	while actual_boxes != box_counts:
		if box_counts < 0:
			break
		if actual_boxes > box_counts:
			base_boxes.get_child(base_boxes.get_child_count() - 1).queue_free()
			actual_boxes -= 1
		else:
			var new_box = stress_box_class.instantiate()
			base_boxes.add_child(new_box)
			actual_boxes += 1
		pass
	pass

func change_settings():
	edit_mode = !edit_mode
	settings_button.modulate = Color.YELLOW if edit_mode else Color.WHITE
	
	for box in base_boxes.get_children():
		box.edit_mode_flag = edit_mode
	pass
