extends Control
#class_name drag_container_cell

signal dragging
signal end_dragging
signal start_dragging

var dragged := false
var offset : Vector2
var left_border  : float
var right_border : float

var drag_timer := Timer.new()

func _ready() -> void:
	set_borders()
	add_child(drag_timer)
	drag_timer.one_shot = true
	drag_timer.autostart = false
	drag_timer.timeout.connect(Callable(self, "start_drag"))
	pass

func set_borders():
	var parent_node = get_parent_control()
	left_border = parent_node.global_position.x
	right_border = parent_node.global_position.x + parent_node.size.x
	pass



func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && dragged:
		var next_position = get_global_mouse_position().x - offset.x
#		print(next_position)
#		var _left_border = get_pare
		if next_position <= left_border:
			global_position.x = left_border
		elif next_position >= right_border - size.x:
			global_position.x = right_border - size.x
		else:
			global_position.x = next_position
		dragging.emit()
		
	if event is InputEventMouseButton:
		if !event.pressed:
			drag_timer.stop()
			if dragged:
				end_dragging.emit()
			dragged = false
			z_index = 0
	pass


func start_drag():
	print("drag")
	dragged = true
	z_index = 2
	offset = get_local_mouse_position()
	start_dragging.emit()
	pass

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if get_global_rect().has_point(get_global_mouse_position()):
			if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
				drag_timer.start(0.2)
	pass # Replace with function body.
