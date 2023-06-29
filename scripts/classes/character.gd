extends Resource
class_name character

signal new_main_aspect(new_aspect : aspect)
signal new_main_stress(new_stress : stress_counter)


@export var name                        : String
@export var aspects                     : Array[aspect]
@export var skills                      : Array[skill]
@export var stunts                      : Array[stunt]
@export var stresses                    : Array[stress_counter]
@export var consequences                : Array[consequence]
@export var notes                       : Array[String]
@export var points                      := fate_points.new()
@export var portrait                    : Texture2D

@export var last_save_path                      := ""

func _ready() -> void:
	pass

func get_skill_by_id(id : int):
	for _skill in skills:
		if _skill.id == id:
			return _skill
	pass

func add_skill(skill_name : String, value := 0) -> skill:
	var new_skill = skill.new(skill_name, value)
	if skills.size() > 0:
		new_skill.id = skills[-1].id + 1
	else:
		new_skill.id = 0
	skills.append(new_skill)
	return new_skill
	pass

func set_main_aspect(selected_aspect : aspect):
	for _aspect in aspects:
		_aspect = _aspect as aspect
		if selected_aspect != _aspect:
			_aspect.main = false
		else:
			_aspect.main = true
			new_main_aspect.emit(_aspect)
	pass

func set_main_stress(selected_stress : stress_counter):
	for stress in stresses:
		stress = stress as stress_counter
		if selected_stress != stress:
			stress.main = false
		else:
			stress.main = true
			new_main_stress.emit(stress)
	pass
