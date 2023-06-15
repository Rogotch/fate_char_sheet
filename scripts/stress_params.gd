extends HBoxContainer

signal accept_params(selected_params : stress_params)

@export var options       : OptionButton
@export var edit          : LineEdit
@export var box           : TextureRect

var value                 : int
var all_options           : Array[skill]
var selected_id           : int

var params : stress_params

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	set_options([])
#	update_params()
	pass # Replace with function body.

func new_params():
	params = stress_params.new(selected_id, value, box.stress_value)
	pass

func update_params():
	params.update(selected_id, value, box.stress_value)
#	params.skill_id     = selected_id
#	params.skill_value  = value
#	params.stress_value = box.stress_value
	pass

func set_params(new_params : stress_params):
	params           = new_params
	selected_id      = new_params.skill_id
	value            = new_params.skill_value
	box.stress_value = new_params.stress_value
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_options(_all_options : Array[skill]):
	for _skill in _all_options:
		options.add_item(_skill.name)
#	options.select(0)
#	selected_id = 0
	update_params()
	pass

func _on_edit_text_changed(new_text: String) -> void:
	value = int(new_text) if new_text.is_valid_int() else 0
	update_params()
#	print(int(new_text) if new_text.is_valid_int() else "error")
	pass # Replace with function body.


func _on_options_item_selected(index: int) -> void:
	selected_id = index
	update_params()
#	select_skill.emit(all_options[selected_id])
	pass # Replace with function body.

func accept_skill_params():
#	accept_params.emit(stress_params.new())
	pass
