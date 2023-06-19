extends Control
class_name editing_line

signal editing
signal set_new_text

@export var editabled  : bool
@export var line_label : Control
@export var edit       : Control
@export var change     : BaseButton

var focused := false
var redacted_mode := false


func _ready():
	change.pressed.connect(press_button)
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if get_global_rect().has_point(get_global_mouse_position()):
			prints(!focused, editabled)
			if !focused && editabled:
				select(true)
			pass
		else:
			if  focused && !redacted_mode:
				select(false)
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

func select(flag):
	focused = flag
	change.modulate = Color.WHITE if flag else Color.TRANSPARENT 
	pass
