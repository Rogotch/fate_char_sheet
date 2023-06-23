extends line_of_aspect

@export var cons_stress_box  : TextureRect
@export var terms_line       : HBoxContainer

#var my_params : consequence

func set_edit_mod(flag):
	super.set_edit_mod(flag)
	_delete_button.visible = flag
	cons_stress_box.edit_mode_flag = flag
	if !flag:
		change_delete_flag(false)
	pass

func set_params(stunt_data : stunt):
	my_params = stunt_data
	pass

func update():
	stunt_line.text                   = my_params.name
	stunt_edit_line.text              = my_params.name
	stunt_description_line.text       = my_params.description
	stunt_description_edit_line.text  = my_params.description
	pass

#func update_params_boxes():
#	Global.delete_children(params_boxes)
##	print_debug("updated")
#	for term in my_params.terms:
#		term = term as stress_term
#		var term_skill = CharactersSystem.get_skill_by_id(term.skill_id) as skill
#		if term_skill.value >= term.skill_value:
#			var box = term.final_box as stress_box
#			var new_box = stress_box_class.instantiate()
#			params_boxes.add_child(new_box)
#			new_box.set_params(box)
#			new_box.edit_mode_flag = false
##		new_box.edit_mode_flag = edit_mode
#	pass
