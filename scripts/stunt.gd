extends editing_line

signal delete

@export var stunt_edit_line               : LineEdit
@export var stunt_description_edit_line   : TextEdit
@export var stunt_line                    : Label
@export var stunt_description_line        : Label
@export var stunt_description             : ScrollContainer
@export var _del_button                   : TextureButton
@export var expand_button                 : Button
@export var expand_down_texture           : Texture2D
@export var expand_up_texture             : Texture2D

var delete_flag := false
var expanded_flag := true
var my_params : stunt

func _ready() -> void:
	super._ready()
	call_deferred("expand_description", false)
	pass

func set_params(stunt_data : stunt):
	my_params = stunt_data
	pass

func update():
	stunt_line.text                   = my_params.name
	stunt_edit_line.text              = my_params.name
	stunt_description_line.text       = my_params.description
	stunt_description_edit_line.text  = my_params.description
	CharactersSystem.write_save_character.call_deferred()
	pass

func set_text_from_edit():
	set_text(stunt_edit_line.text)
	set_text_stunt_description(stunt_description_edit_line.text)
#	update()
	pass

func set_edit_mod(flag):
	super.set_edit_mod(flag)
	_del_button.visible = flag
	stunt_description_line.visible = !flag
	stunt_description_edit_line.visible = flag
	if !flag:
		change_delete_flag(false)
	pass

func set_text(new_text):
	my_params.name        = new_text
	stunt_line.text       = new_text
#	stunt_edit_line.text  = new_text
	emit_signal("set_new_text")
	pass

func set_text_stunt_description(new_text):
	my_params.description                = new_text
	stunt_description_line.text          = new_text
#	stunt_description_edit_line.text     = new_text
	emit_signal("set_new_text")
	pass

func _on__del_button_pressed() -> void:
	if delete_flag:
		queue_free()
	else:
		change_delete_flag(true)
	pass # Replace with function body.

func change_delete_flag(new_flag : bool):
	delete_flag = new_flag
	_del_button.modulate = Color.WHITE if !delete_flag else Color.RED
#	_del_button.texture_normal = 
	pass

func expand_button_press():
	expand_description(!expanded_flag)
	pass

func expant_to(new_size : float):
	var expand_tween = create_tween()
	expand_tween.tween_property(stunt_description, "custom_minimum_size:y", new_size, 0.2)
	expand_tween.play()
	pass


func _on_descr_edit_resized() -> void:
	expand_description(true)
	pass # Replace with function body.

func expand_description(flag):
	expanded_flag = flag
	if flag:
		expant_to(stunt_description_edit_line.get_combined_minimum_size().y if redacted_mode else stunt_description_line.get_combined_minimum_size().y)
	else:
		expant_to(0)
	expand_button.icon = expand_up_texture if expanded_flag else expand_down_texture
	pass

func _on_delete_button_delete() -> void:
	var _character = CharactersSystem.main_character as character
	_character.stunts.erase(my_params)
	delete.emit()
	queue_free()
	pass # Replace with function body.
