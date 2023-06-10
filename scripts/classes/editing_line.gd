extends BoxContainer
class_name editing_line

signal editing
signal set_new_text

@export var editabled  : bool
@export var line_label : Control
@export var edit       : Control
@export var change     : Button

var focused := false
var redacted_mode := false


func _init():
	aspect
	pass

func _ready():
	change.connect("pressed", Callable(self,"press_button"))
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if get_global_rect().has_point(get_global_mouse_position()):
			prints(!focused, editabled)
			if !focused && editabled:
				focused = true
#				change.visible = true
				change.modulate = Color.WHITE
			pass
		else:
			if  focused && !redacted_mode:
				focused = false
#				change.visible = false
				change.modulate = Color.TRANSPARENT
	pass

func press_button():
	if redacted_mode:
		set_text_from_edit()
		set_edit_mod(false)
	else:
		emit_signal("editing")
		set_edit_mod(true)
	redacted_mode = !redacted_mode
	pass

func set_edit_mod(flag):
	line_label.visible = !flag
	edit.visible = flag
	pass

func set_text_from_edit():
	set_text(edit.text)
	pass

func set_text(new_text):
	line_label.text = new_text
	emit_signal("set_new_text")
	pass
