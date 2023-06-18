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
