extends VBoxContainer

@export var fate_point_size       : Vector2
@export var fate_point_texture    : Texture2D

@export var counter_text          : Label
@export var points                : HBoxContainer
@export var max_counter           : Label
@export var edit_max              : LineEdit
@export var buttons               : HBoxContainer
@export var edit_max_button       : TextureButton

var params          : fate_points
var redacted_flag   := false

func _ready() -> void:
	pass

func set_params(new_data : fate_points):
	params = new_data
	update()
	pass

func new_params():
	params = fate_points.new()
	update()
	pass

func update():
	Global.delete_children(points)
	counter_text.visible = params.value > 3
	max_counter.text = "%d" % params.max_value
	edit_max.text = str(params.max_value)
	if params.value > 3:
		counter_text.text = "(%d)" % params.value
	
	var counter = 3
	for i in 3 if params.max_value > 3 else params.max_value:
		var new_points = TextureRect.new()
		points.add_child(new_points)
		new_points.custom_minimum_size = fate_point_size
		new_points.expand_mode   = TextureRect.EXPAND_IGNORE_SIZE
		new_points.stretch_mode  = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		new_points.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		new_points.size_flags_vertical   = Control.SIZE_SHRINK_CENTER
		new_points.texture = fate_point_texture
		new_points.modulate = Color.DARK_GRAY if counter > params.value else Color.WHITE
		counter -= 1
	pass

func change_points_count(additional_value : int):
	params.value = params.value + additional_value if params.value + additional_value > 0 else 0
	update()
	pass


func _on_edit_max(new_text: String) -> void:
	params.max_value = int(new_text) if new_text.is_valid_int() else 0
	update()
	pass # Replace with function body.


func _on_edit_max_text_submitted(new_text: String) -> void:
	params.max_value = int(new_text) if new_text.is_valid_int() else 0
	set_redacted_flag(false)
	update()
	pass # Replace with function body.


func _on_edit_max_button_pressed() -> void:
	set_redacted_flag(!redacted_flag)
	pass # Replace with function body.

func set_redacted_flag(flag : bool):
	redacted_flag       =  flag
	max_counter.visible = !flag
	edit_max.visible    =  flag
	edit_max.grab_focus()
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			if !get_global_rect().has_point(get_global_mouse_position()):
				set_redacted_flag(false)
	pass
