extends HBoxContainer

signal change_value(value : int)

@export var max_value : int
@export var min_value : int

@export_enum("left", "right") var slider_alignment := "left"

@export_category("Nodes")
@export var v_slider: VSlider
@export var numbers: VBoxContainer

var label_settings

var slider_value : int

func _ready() -> void:
	if slider_alignment == "right":
		move_child(numbers, 0)
	label_settings = LabelSettings.new()
	label_settings.font_size = 32
	fill_numbers()
	v_slider.min_value = min_value
	v_slider.max_value = max_value
	
	set_value(0)
	pass

func fill_numbers():
	for i in range(max_value, min_value - 1, -1):
		var new_label = Label.new()
		numbers.add_child(new_label)
		new_label.label_settings = label_settings
		new_label.custom_minimum_size.y = 22
		new_label.set_meta("value", i)
		new_label.text = ("%2d" % i) if slider_alignment == "left" else get_right_value_string(i)
		pass
	pass

func get_right_value_string(value) -> String:
	var right_value
	if value >= 10:
		right_value = "%3d" % value
	elif value >= 0:
		right_value = " " + ("%-2d" % value)
	else:
		right_value = ("%-2d" % value) + " "
	return right_value
	pass

func set_number(value : int):
	for num in numbers.get_children():
		var num_value = num.get_meta("value")
		if num_value == value:
			num.modulate = Color.ORANGE
		elif num_value > value:
			num.modulate = Color.DARK_GRAY
		else:
			num.modulate = Color.WHITE
	pass

func _on_v_slider_value_changed(value: float) -> void:
	slider_value = value
	set_number(int(value))
	change_value.emit(value)
	pass # Replace with function body.

func set_value(value : int) -> void:
	slider_value = value
	v_slider.value = value
	set_number(value)
	change_value.emit(value)
	pass
