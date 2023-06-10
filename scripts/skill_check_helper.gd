extends ScrollContainer
@export var text     : RichTextLabel
@export var buttons  : VBoxContainer 

var test_label = "[{stile_suc}]{ss}[/color]\n[{suc}]{sc}[/color]\n[{tie}]{ti}[/color]\n[{fail}]{fi}[/color]"

var actual_result   : Global.OUTCOMES_TYPE
var selected_action 
var saved_result := 0

func _ready() -> void:
	select_action(0)
#	action_result(Global.OUTCOMES_TYPE.TIE)
	pass

func action_result(result_value):
	saved_result = result_value
	var result_type = Global.get_outcome_type_by_value(result_value)
	actual_result = result_type
	
	if selected_action == null:
		text.set_text("")
		return
	
	var final_string = ""
	
	var str_ss := ""
	var str_sc := ""
	var str_ti := ""
	var str_fi := ""
	
	var action_key = Global.get_action_key(selected_action)
	var key_ss = tr("RESULT_DESCRIPTION_STYLE_SUCCESS_" + action_key)
	var key_sc = tr("RESULT_DESCRIPTION_SUCCESS_" + action_key)
	var key_ti = tr("RESULT_DESCRIPTION_TIE_" + action_key)
	var key_fi = tr("RESULT_DESCRIPTION_FAIL_" + action_key)
	
	var damage_fin = 0 if result_value < 0 else result_value
	var dmg_key = "[shake rate=20.0 level=5]{text}[/shake]" if result_value >= 3 else "{text}"
	dmg_key = dmg_key.format({"text" : str(damage_fin)})
	
	match  result_type:
		Global.OUTCOMES_TYPE.SUCCEED_STILE:
			str_ss = "color=orange"
			str_sc = "color=white"
			str_ti = "color=white"
			str_fi = "color=white"
		Global.OUTCOMES_TYPE.SUCCEED:
			str_ss = "color=gray"
			str_sc = "color=orange"
			str_ti = "color=white"
			str_fi = "color=white"
		Global.OUTCOMES_TYPE.TIE:
			str_ss = "color=gray"
			str_sc = "color=gray"
			str_ti = "color=orange"
			str_fi = "color=white"
		Global.OUTCOMES_TYPE.FAIL:
			str_ss = "color=gray"
			str_sc = "color=gray"
			str_ti = "color=gray"
			str_fi = "color=orange"
	final_string = test_label.format({"stile_suc" : str_ss, "suc" : str_sc, "tie" : str_ti, "fail" : str_fi, "ss" : key_ss, "sc" : key_sc, "ti" : key_ti, "fi" : key_fi})
	final_string = final_string.format({"dmg" : dmg_key})
	text.set_text(final_string)
	pass

func select_action(action : Global.ACTION_TYPE):
	if action == selected_action:
		selected_action = null
	else:
		selected_action = action
	set_buttons()
	action_result(saved_result)
	pass

func set_buttons():
	for button in buttons.get_children():
		button.modulate = Color.DARK_GRAY
	if selected_action != null:
		buttons.get_child(selected_action).modulate = Color.ORANGE
	pass

