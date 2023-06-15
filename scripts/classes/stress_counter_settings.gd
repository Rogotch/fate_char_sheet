extends Resource
class_name stress_params

@export var skill_id      : int
@export var skill_value   : int
@export var stress_value  : String

func _init(new_id, new_value, new_stress_value) -> void:
	update(new_id, new_value, new_stress_value)
	pass

func update(new_id, new_value, new_stress_value) -> void:
	skill_id       = new_id
	skill_value    = new_value
	stress_value   = new_stress_value
	pass
