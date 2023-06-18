extends Resource
class_name stress_term

@export var skill_id      : int
@export var skill_value   : int
@export var stress_value  : String
@export var final_box     : stress_box

func _init(new_id, new_value, new_stress_value) -> void:
	update(new_id, new_value, new_stress_value)
	final_box = stress_box.new()
	pass

func update(new_id, new_value, new_stress_value) -> void:
	skill_id       = new_id
	skill_value    = new_value
	stress_value   = new_stress_value
	pass

