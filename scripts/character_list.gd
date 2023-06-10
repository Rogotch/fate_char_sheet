extends Control
@export var actions_descriptions          : ScrollContainer
@export var skills                        : VBoxContainer
@export var bar                           : Control
@export var roller                        : VBoxContainer

var roll_result := 0
var selecting_skill : skill

func _on_bar_result(value) -> void:
	actions_descriptions.action_result(value)
	pass # Replace with function body.


func _on_roller_roll(value) -> void:
	roll_result = value
	set_bar_value()
	pass # Replace with function body.


func _on_skills_select_skill(skill_data : skill) -> void:
	selecting_skill = skill_data
	roller.set_skill(skill_data.value)
	set_bar_value()
	pass # Replace with function body.

func set_bar_value():
	var skill_value = selecting_skill.value if selecting_skill != null else 0
	bar.set_value(skill_value + roll_result, true)
	pass
