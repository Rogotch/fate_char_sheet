extends TextureRect

@export var check         : TextureRect
@export var value         : Label
@export var edit          : LineEdit

var check_flag := false
var edit_flag  := false
var stress_value : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pressed() -> void:
	edit_mode(!edit_flag)
#	set_check(!check_flag)
pass # Replace with function body.

func set_check(flag) -> void:
	check_flag = flag
	check.visible = flag
	pass

func set_value(new_value):
	value.text = str(new_value)
	pass

func edit_mode(flag):
	edit_flag = flag
	value.visible = !flag
	edit.visible  =  flag
	if flag:
		edit.text  = value.text
		edit.grab_focus()
	else:
		value.text =  edit.text
	pass


func submitted(new_text: String) -> void:
	stress_value = new_text
	edit_mode(false)
	pass



func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var has_point   = !edit.get_global_rect().has_point(get_global_mouse_position())
		var button_flag = (event.button_index == MOUSE_BUTTON_LEFT || event.button_index == MOUSE_BUTTON_RIGHT)
		if edit_flag:
			if has_point && button_flag:
				submitted(edit.text)
	pass # Replace with function body.
