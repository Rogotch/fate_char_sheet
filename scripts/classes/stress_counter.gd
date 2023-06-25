extends Resource
class_name stress_counter

@export var name  := tr("STRESS_KEY")  : set = set_stress_name
@export var boxes : Array[stress_box]  : set = set_boxes
@export var terms : Array[stress_term] : set = set_terms
@export var main  : bool

func _init() -> void:
	check_labels()
	pass

func add_box(new_value := "", checked_flag := false):
	boxes.append(stress_box.new(new_value, checked_flag))
	pass

func remove_box(index : int):
	boxes.remove_at(index)
	pass

func remove_last_box():
	if boxes.size() > 0:
		boxes.remove_at(boxes.size() - 1)
	pass


func check_labels():
	if name.is_empty():
		name = tr("BASE_STRESS_NAME")
	pass

func set_stress_name(new_stress_name : String):
	name = new_stress_name
	emit_changed()
	pass

func set_boxes(new_boxes : Array[stress_box]):
	boxes = new_boxes
	for box in boxes:
		if !box.is_connected("changed", emit_changed):
			box.changed.connect(emit_changed)
	emit_changed()
	pass

func set_terms(new_terms : Array[stress_term]):
	terms = new_terms
	for term in terms:
		if !term.is_connected("changed", emit_changed):
			term.changed.connect(emit_changed)
	emit_changed()
	pass
