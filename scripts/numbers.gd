extends HBoxContainer
@export var left     : Label
@export var right    : Label
@export var number   : int

func _ready() -> void:
	pass

func set_number(value : int):
	left.text  = "%2d" % value
	
	var right_value
	if value >= 10:
		right_value = "%2d" % value
	elif value >= 0:
		right_value = " " + ("%-2d" % value)
	else:
		right_value = ("%-2d" % value) + " "
		
		
	
	right.text = right_value
	pass

