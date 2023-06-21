extends Resource

class_name stunt

@export var name        : String
@export var description : String

func _init():
	check_labels()
	pass

func check_labels():
	if name.is_empty():
		name = tr("BASE_STUNT_NAME")
	if description.is_empty():
		description = tr("BASE_STUNT_DESCRIPTION")
	pass
