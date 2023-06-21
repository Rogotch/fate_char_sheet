extends Resource
class_name stress_counter

@export var name  := tr("STRESS_KEY")
@export var boxes : Array[stress_box]
@export var terms : Array[stress_term]

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
