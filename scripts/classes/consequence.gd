extends Resource
class_name consequence

@export var name     : String
@export var type     : String
@export var stress   : stress_box
@export var terms    : Array[stress_term]

func _init() -> void:
	if stress == null:
		stress = stress_box.new()
	pass
