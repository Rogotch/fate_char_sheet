extends editing_line
class_name line_of_aspect

signal delete

@export var aspect_edit_line        : LineEdit
@export var aspect_type_edit_line   : LineEdit
@export var aspect_line             : Label
@export var aspect_type_line        : Label
@export var _delete_button          : TextureButton
@export var set_as_main             : Button

var delete_flag   := false
var my_params     : aspect 

func set_text_from_edit():
	set_text(aspect_edit_line.text)
	set_text_aspect_type(aspect_type_edit_line.text)
	update()
	pass


func set_params(aspect_data : aspect):
	my_params = aspect_data
	my_params.changed.connect(update)
	pass

func update():
	aspect_line.text             = my_params.name
	aspect_edit_line.text        = my_params.name
	aspect_type_line.text        = my_params.effect
	aspect_type_edit_line.text   = my_params.effect
	CharactersSystem.write_save_character.call_deferred()
	pass


func set_edit_mod(flag):
	super.set_edit_mod(flag)
	_delete_button.visible = flag
	set_as_main.visible = flag
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


func _on_set_as_main_pressed() -> void:
	CharactersSystem.main_character.set_main_aspect(my_params)
	pass # Replace with function body.

func _on_delete_button_delete() -> void:
	var _character = CharactersSystem.main_character as character
	_character.aspects.erase(my_params)
	delete.emit()
	queue_free()
	pass # Replace with function body.
