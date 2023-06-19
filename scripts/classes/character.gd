extends Resource

class_name character

var name                        : String
var aspects                     : Array[aspect]
var skills                      : Array[skill]
var additional_stress_term      : Array[stress_term]


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
