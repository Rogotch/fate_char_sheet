extends Resource

class_name aspect

@export_multiline var name     : String
@export_multiline var effect   : String

func _init():
	check_labels()
#	check_labels.call_deferred()
	pass

func check_labels():
	if name.is_empty():
		name = tr("BASE_ASPECT_NAME")
	if effect.is_empty():
		effect = tr("BASE_ASPECT_TYPE")
	pass
