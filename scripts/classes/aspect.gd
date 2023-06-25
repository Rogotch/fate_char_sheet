extends Resource

class_name aspect

@export_multiline var name     : String : set = set_aspect_name
@export_multiline var effect   : String : set = set_aspect_effect
@export           var main     : bool

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

func set_aspect_name(new_aspect_name : String):
	name = new_aspect_name
	emit_changed()
	pass

func set_aspect_effect(new_aspect_effect : String):
	effect = new_aspect_effect
	emit_changed()
	pass
