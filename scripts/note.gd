extends VBoxContainer

signal delete

@export var text             : RichTextLabel
@export var edit             : TextEdit
@export var edit_button      : Button

var note_text : String
var edit_flag : bool
var min_size := Vector2.ZERO

#func _ready() -> void:
#	set_min_x_size.call_deferred()
#	pass
#
#func set_min_x_size():
#	set_text_size_value(note_text.length())
#	pass
#
#func set_min_x_size_edit():
#	set_text_size_value(edit.text.length())
#	pass

func set_text_size_value(text_length : int):
	print_debug(text_length)
	if text_length > 150:
		custom_minimum_size.x = (get_parent().size.x) - 2
	elif text_length > 100:
		custom_minimum_size.x = (get_parent().size.x/2) - 7
	elif text_length > 60:
		custom_minimum_size.x = (get_parent().size.x/3) - 7
	else:
		custom_minimum_size.x = (get_parent().size.x/5) - 7
	
	pass

func set_edit(flag : bool):
	edit_flag     =  flag
	text.visible  = !flag
	edit.visible  =  flag
	if flag:
		edit.grab_focus()
	else:
		note_text = edit.text
	set_text(note_text)
	update()
	pass

func _on_edit_button_pressed() -> void:
	set_edit(!edit_flag)
	pass # Replace with function body.

func set_params(new_text : String):
#	var _character = CharactersSystem.main_character as character
	set_text(new_text)
	note_text = new_text
	update()
	pass

func update():
	edit.text = note_text
	text.text = note_text
	CharactersSystem.write_save_character.call_deferred()
#	set_min_x_size()
	pass

func set_text(new_text : String):
	var _character = CharactersSystem.main_character as character
	var my_index = get_index()
	if _character.notes.size() > my_index:
		_character.notes[my_index] = new_text
	else:
		_character.notes.append(new_text)
	pass

func _on_text_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == MOUSE_BUTTON_RIGHT:
			set_edit(true)
	pass # Replace with function body.


func _on_delete_button_delete() -> void:
	delete.emit()
	var _character = CharactersSystem.main_character as character
	var my_index = get_index()
	if _character.notes.size() > my_index:
		_character.notes.remove_at(my_index)
	else:
		_character.notes.erase(note_text)
	queue_free()
	pass # Replace with function body.
