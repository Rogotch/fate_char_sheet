extends editing_line
class_name line_of_aspect

@export var aspect_edit_line        : LineEdit
@export var aspect_type_edit_line   : LineEdit
@export var aspect_line             : Label
@export var aspect_type_line        : Label
@export var _delete_button           : Button

var delete_flag   := false
var my_params     : aspect 

func set_text_from_edit():
	set_text(aspect_edit_line.text)
	set_text_aspect_type(aspect_type_edit_line.text)
	update()
	pass


func set_params(aspect_data : aspect):
	my_params = aspect_data
	pass

func update():
	aspect_line.text             = my_params.name
	aspect_edit_line.text        = my_params.name
	aspect_type_line.text        = my_params.effect
	aspect_type_edit_line.text   = my_params.effect
	pass


func set_edit_mod(flag):
	super.set_edit_mod(flag)
	_delete_button.visible = flag
	if !flag:
		change_delete_flag(false)
	pass

func set_text(new_text):
	my_params.name = new_text
	emit_signal("set_new_text")
	pass

func set_text_aspect_type(new_text):
	my_params.effect = new_text
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
	_delete_button.modulate = Color.WHITE if !delete_flag else Color.RED
#	delete_button.texture_normal = 
	pass

func submit_text(new_text : String):
	set_text_from_edit()
	set_edit_mod(false)
	redacted_mode = false
	pass
