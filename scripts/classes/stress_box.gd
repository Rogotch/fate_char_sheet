extends Resource
class_name stress_box

@export var value      : String
@export var checked    : bool

func _init(new_value := "", checked_flag := false):
	value     = new_value
	checked   = checked_flag
	pass
