extends Resource
class_name stress_box

@export var value      : String : set = set_value
@export var checked    : bool   : set = set_checked

func _init(new_value := "", checked_flag := false):
	value     = new_value
	checked   = checked_flag
	pass

func set_value(new_value : String):
	value     = new_value
	emit_changed()
	pass
	
func set_checked(new_value : bool):
	checked   = new_value
	emit_changed()
	pass
