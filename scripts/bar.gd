extends Control

signal result(value)

@export var slider_left  : HBoxContainer
@export var slider_right : HBoxContainer

var value_left  : int
var value_right : int

func _ready() -> void:
#	fill_numbers()
	pass

#func fill_numbers():
#	for i in range(13, -5, -1):
#		var new_numbers = numbers_class.instantiate()
#		vbox.add_child(new_numbers)
#		new_numbers.set_number(i)
#		pass
#	pass


func _on_slider_left_change_value(value) -> void:
	value_left = value
	check_result()
	pass # Replace with function body.

func _on_slider_right_change_value(value) -> void:
	value_right = value
	check_result()
	pass # Replace with function body.

func check_result():
	var result_value = value_left - value_right
	var outcome_result = Global.get_outcome_type_by_value(result_value)
	result.emit(result_value)
	pass

func set_value(value : int, left_flag : bool):
	if left_flag:
		slider_left.set_value(value)
	else:
		slider_right.set_value(value)
	pass
