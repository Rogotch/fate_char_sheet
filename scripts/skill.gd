extends drag_container_cell

signal select(flag : bool)

@export var points                 : HBoxContainer
@export var buttons                : HBoxContainer
@export var name_label             : Label
@export var edit_label             : LineEdit
@export var edit_button            : TextureButton
@export var _delete_button         : TextureButton
@export var skill_name             : HBoxContainer
@export var color_picker_button    : ColorPickerButton
@export var drag_button            : TextureButton

@export var name_size_offset  : int
@export var cross             : Texture2D
@export var check             : Texture2D

@onready var point_texture = preload("res://Sprites/Icon03.png")

var skill_params : skill

var delete_flag := false
var selecting_flag := false
var editing_flag := false


func _ready() -> void:
	super._ready()
	edit_button.self_modulate = Color.ORANGE
	
#	set_skill_value(5)
	pass

func update():
	name_label.text = skill_params.name
	set_skill_value(skill_params.value)
	color_picker_button.color = skill_params.modulation
	points.modulate = skill_params.modulation
	name_label.modulate = Color.ORANGE if selecting_flag else skill_params.modulation
	pass

func get_name_size():
	return buttons.get_rect().size.x + name_label.get_rect().size.x + _delete_button.get_rect().size.x + name_size_offset
	pass

func set_name_size(value : float):
	skill_name.custom_minimum_size.x = value
	pass

func set_params(new_skill_params : skill):
	skill_params = new_skill_params
	name_label.text = skill_params.name
	set_skill_value(skill_params.value)
	update()
	pass

#func set_skill(skill_name : String, skill_value : int):
#	skill_params = skill.new(skill_name, skill_value)
#	name_label.text = skill_name
#	set_skill_value(skill_value)
#	pass

func set_skill_value(new_value : int):
	skill_params.value = new_value
	Global.delete_children(points)
	if new_value > 5:
		var counter_label = Label.new()
		var label_settings = LabelSettings.new()
		label_settings.font_size = 14
		counter_label.label_settings = label_settings
		counter_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		counter_label.text = "(%s)" % new_value
		points.add_child(counter_label)
		new_value = 1
	
	for i in new_value:
		var point = TextureRect.new()
		point.texture = point_texture
		point.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		point.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
		point.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		point.custom_minimum_size = Vector2(10, 10)
		points.add_child(point)
	
	if selecting_flag:
		select.emit(true)
	pass


func _on_add_point_pressed() -> void:
	set_skill_value(skill_params.value + 1)
	pass # Replace with function body.


func _on_substract_point_pressed() -> void:
	if skill_params.value - 1 >= 0:
		set_skill_value(skill_params.value - 1)
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var focused_color   = Color.WHITE
		var unfocused_color = Color.TRANSPARENT
		if get_global_rect().has_point(get_global_mouse_position()) && !get_parent().active_dragging:
			buttons.modulate                  = focused_color
			_delete_button.modulate           = focused_color
			edit_button.modulate              = focused_color
			color_picker_button.modulate      = focused_color
			drag_button.modulate              = focused_color
		else:
			buttons.modulate                  = unfocused_color
			_delete_button.modulate           = unfocused_color
			edit_button.modulate              = unfocused_color
			color_picker_button.modulate      = unfocused_color
			drag_button.modulate              = unfocused_color
			change_delete_flag(false)
		
		if dragged:
			_dragging()
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			var _delete_button_rect = _delete_button.get_global_rect()
			var buttons_rect       = buttons.get_global_rect()
			
			var mouse_position = get_global_mouse_position()
			
			var buttons_flag = !_delete_button_rect.has_point(mouse_position) && !buttons_rect.has_point(mouse_position)
			if name_label.get_global_rect().has_point(mouse_position) && buttons_flag:
#				call_deferred("emit_signal", "select", !selecting_flag)
				select.emit(!selecting_flag)
		
		if !event.pressed:
			drag_timer.stop()
			if dragged:
				dragged = false
				end_dragging.emit()
			dragged = false
			z_index = 0
	pass


func _on__delete_button_pressed() -> void:
	if delete_flag:
		set_select(false)
		queue_free()
	else:
		change_delete_flag(true)
	pass # Replace with function body.

func change_delete_flag(new_flag : bool):
	delete_flag = new_flag
	_delete_button.texture_normal = cross if !delete_flag else check
#	_delete_button.texture_normal = 
	pass

func set_select(flag : bool):
	selecting_flag = flag
	name_label.modulate = Color.ORANGE if flag else skill_params.modulation
	pass

func set_label_modulate(selected_color : Color):
	name_label.modulate = selected_color
	pass

func modulate_off():
	name_label.modulate = Color.ORANGE if selecting_flag else skill_params.modulation
	pass

func set_edit():
	editing_flag = !editing_flag
	name_label.visible = !editing_flag
	edit_label.visible =  editing_flag
	edit_label.custom_minimum_size =  name_label.get_combined_minimum_size() + Vector2(20, 0)
	if editing_flag:
		edit_button.self_modulate = Color.FOREST_GREEN
		edit_label.text = name_label.text
		edit_label.grab_focus()
	else:
		edit_button.self_modulate = Color.ORANGE
		name_label.text   = edit_label.text
		skill_params.name = edit_label.text
	pass


func _color_changed(color: Color) -> void:
	if skill_params != null:
		skill_params.modulation = color
	update()
	pass # Replace with function body.

func _gui_input(event: InputEvent) -> void:
#	if event is InputEventMouseButton:
#		if event.pressed && drag_button.get_global_rect().has_point(get_global_mouse_position()):
#			if event.button_index == MOUSE_BUTTON_LEFT:
#				drag_timer.start(0.2)
	pass # Replace with function body.


func _on_drag_button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed && drag_button.get_global_rect().has_point(get_global_mouse_position()):
			if event.button_index == MOUSE_BUTTON_LEFT:
				drag_timer.start(0.2)
	pass # Replace with function body.

func start_drag():
#	print("drag")
	dragged = true
	z_index = 2
	if drag_button.get_global_rect().has_point(get_global_mouse_position()):
		offset = get_local_mouse_position()
	else:
		offset = drag_button.size/2
	start_dragging.emit()
	pass


func _on_edit_skill_text_submitted(new_text: String) -> void:
	set_edit()
	pass # Replace with function body.
