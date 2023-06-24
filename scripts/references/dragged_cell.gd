extends HBoxContainer
class_name drag_container_cell

signal dragging
signal end_dragging
signal start_dragging

var dragged := false
var offset : Vector2
var top_border  : float
var down_border : float

var drag_timer := Timer.new()

func _ready() -> void:
	set_borders.call_deferred()
	add_child(drag_timer)
	drag_timer.one_shot = true
	drag_timer.autostart = false
	drag_timer.timeout.connect(Callable(self, "start_drag"))
	pass

func set_borders():
	var parent_node = get_parent_control().get_parent_control()
	top_border = parent_node.global_position.y
	down_border = parent_node.global_position.y + parent_node.size.y
	pass



func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && dragged:
		_dragging()
		
	if event is InputEventMouseButton:
		if !event.pressed:
			drag_timer.stop()
			if dragged:
				end_dragging.emit()
			dragged = false
			z_index = 0
	pass

func _dragging():
	var next_position = get_global_mouse_position().y - offset.y
#		print(next_position)
#		var _left_border = get_pare
	if next_position <= top_border:
		global_position.y = top_border
	elif next_position >= down_border - size.y:
		global_position.y = down_border - size.y
	else:
		global_position.y = next_position
#	print_debug(global_position.y, " ", top_border, " ", down_border - size.y)
	dragging.emit()
	pass


func start_drag():
#	print("drag")
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
