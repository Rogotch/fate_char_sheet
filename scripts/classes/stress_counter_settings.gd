extends Resource
class_name stress_term

@export var skill_id      : int      : set = set_id
@export var skill_value   : int      : set = set_skill_value
@export var stress_value  : String   : set = set_stress_value
@export var final_box     : stress_box

func _init() -> void:
#	update(new_id, new_value, new_stress_value)
	final_box = stress_box.new()
	pass

func update(new_id, new_value, new_stress_value) -> void:
	skill_id       = new_id
	skill_value    = new_value
	stress_value   = new_stress_value
	pass

func set_id(value : int):
	skill_id = value
	emit_changed()
	pass

func set_skill_value(value : int):
	skill_value = value
	emit_changed()
	pass

func set_stress_value(value : String):
	stress_value = value
	emit_changed()
	pass
#
#func set_final_box(value : int):
#	emit_changed()
#	pass
