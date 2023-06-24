#@tool
extends Container
class_name drag_container

signal change_order

func _notification(what):
	if what == NOTIFICATION_SORT_CHILDREN:
		# Must re-sort the children
		call_deferred("set_childs_positions")
	pass

func _ready() -> void:
	queue_sort()
	pass

func drag_cell():
	var all_children = get_children()
	var childs_count = all_children.size()
	var counter = 0
#	var step = get_y_step()
	for c in all_children:
		var step = c.get_combined_minimum_size().y
		if c.dragged:
			var drag_position = get_y_child_position(counter, c)
			if  drag_position < c.position.y  && c.position.y - drag_position >= step/2:
				if counter < childs_count:
					move_child(c, counter + 1)
					change_order.emit()
			elif c.position.y < drag_position && drag_position - c.position.y >= step/2:
				if counter > 0:
					move_child(c, counter - 1)
					change_order.emit()
			return
		counter += 1
	set_childs_positions()
	pass

func set_childs_positions():
	var all_children = get_children()
	var childs_count = all_children.size()
	
	var counter = 0
	var step = size.y/(childs_count + 1)
	for c in all_children:
		if !c.dragged:
#			c.position.y = size.y/2 - c.size.y/2 
			c.position.y = get_y_child_position(counter, c)
		counter += 1
	pass

func get_y_child_position(counter : int, child_node : Control):
#	var step = get_y_step()
	var step = child_node.get_combined_minimum_size().y
	return (counter * step) + step/2.0 - child_node.size.y/2 
	pass

func get_y_step():
	var childs_count = get_child_count()
	var y_size = size.y
	return y_size/(childs_count + 1)
	pass

