extends Control

@export var aspect_name              : Control
@export var aspect_name_title        : Label
@export var aspect_name_text         : Label
@export var aspect_name_line_edit    : LineEdit
@export var aspect_name_button       : Button
@export var aspect_effect            : Control
@export var aspect_effect_title      : Label
@export var aspect_effect_text       : Label
@export var aspect_effect_line_edit  : LineEdit
@export var aspect_effect_button     : Button
@export var aspect_button            : Button

#@onready var aspect_name              = get_node(_aspect_name)
#@onready var aspect_name_title        = get_node(_aspect_name_title)
#@onready var aspect_name_text         = get_node(_aspect_name_text)
#@onready var aspect_name_line_edit    = get_node(_aspect_name_line_edit)
#@onready var aspect_name_button       = get_node(_aspect_name_button)
#@onready var aspect_effect            = get_node(_aspect_effect)
#@onready var aspect_effect_title      = get_node(_aspect_effect_title)
#@onready var aspect_effect_text       = get_node(_aspect_effect_text)
#@onready var aspect_effect_line_edit  = get_node(_aspect_effect_line_edit)
#@onready var aspect_effect_button     = get_node(_aspect_effect_button)
#@onready var aspect_button            = get_node(_aspect_button)

var redacted_mode_name   := false
var redacted_mode_effect := false
var focused := false

func _ready() -> void:
	aspect_button.connect("pressed",Callable(self,"delete_me"))
	SignalsBus.connect("open_edit_line",Callable(self,"open_editing"))
#	aspect_name_text.Text = tr("")
	pass

func press_name_button():
	if redacted_mode_name:
		set_name_text()
		set_edit_name_mod(false)
#		aspect_name_button.text = 
	else:
		set_edit_name_mod(true)
#		aspect_name_line_edit.text = aspect_name_text.text
#		SignalsBus.emit_signal("open_edit_line", self)
	redacted_mode_name = !redacted_mode_name
	pass

func open_editing(entity):
	if entity != self:
		pass
#		set_edit_mod(false)
#		redacted_mode_name = false
#		redacted_mode_effect = false
#		focused = false
#		aspect_button.visible = false
#		aspect_name_button.visible = false
	pass

func set_edit_mod(flag):
	set_edit_name_mod(flag)
	set_edit_effect_mod(flag)
	pass

func set_edit_name_mod(flag):
	aspect_name.visible = !flag
	aspect_name_line_edit.visible = flag
	pass

func set_edit_effect_mod(flag):
	aspect_effect.visible = !flag
	aspect_effect_line_edit.visible = flag
	pass

func press_effect_button():
	if redacted_mode_effect:
		set_effect_text()
		set_edit_effect_mod(false)
	else:
		set_edit_effect_mod(true)
	redacted_mode_effect = !redacted_mode_effect
	pass

func set_name_text():
	aspect_name_text.text = aspect_name_line_edit.text
	pass

func set_effect_text():
	aspect_effect_text.text = aspect_effect_line_edit.text
	pass

func name_edit_text_changed(new_text: String) -> void:
	aspect_name_text.text = new_text
	pass # Replace with function body.


func effect_edit_text_changed(new_text: String) -> void:
	aspect_effect_text.text = new_text
	pass # Replace with function body.

func delete_me():
	queue_free()
	pass


func _on_aspect_field_mouse_entered() -> void:
	aspect_button.visible = true
	pass # Replace with function body.


func _on_aspect_field_mouse_exited() -> void:
	aspect_button.visible = false
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
#	if event is InputEventMouseMotion:
#		if get_global_rect().has_point(get_global_mouse_position()):
#			if !focused:
#				focused = true
#				aspect_button.visible = true
#				aspect_name_button.visible = true
#				aspect_effect_button.visible = true
#			pass
#		else:
#			if  focused && !redacted_mode_name:
#				focused = false
#				aspect_button.visible = false
#				aspect_name_button.visible = false
#				aspect_effect_button.visible = false
	pass
