extends editing_line

@export var aspect_edit_line        : LineEdit
@export var aspect_type_edit_line   : LineEdit
@export var aspect_line             : Label
@export var aspect_type_line        : Label
@export var delete_button           : Button

var delete_flag := false

func set_text_from_edit():
	set_text(aspect_edit_line.text)
	set_text_aspect_type(aspect_type_edit_line.text)
	pass

func set_edit_mod(flag):
	super.set_edit_mod(flag)
	delete_button.visible = flag
	if !flag:
		change_delete_flag(false)
	pass

func set_text(new_text):
	aspect_line.text = new_text
	emit_signal("set_new_text")
	pass

func set_text_aspect_type(new_text):
	aspect_type_line.text = new_text
	emit_signal("set_new_text")
	pass

func _on_delete_button_pressed() -> void:
	if delete_flag:
		queue_free()
	else:
		change_delete_flag(true)
	pass # Replace with function body.

func change_delete_flag(new_flag : bool):
	delete_flag = new_flag
	delete_button.modulate = Color.WHITE if !delete_flag else Color.RED
#	delete_button.texture_normal = 
	pass
