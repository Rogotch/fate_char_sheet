extends Button
class_name add_button

@export var what  : PackedScene
@export var where : Control

func _ready() -> void:
	pressed.connect(Callable(self, "button_press"))
	pass

func button_press():
	var new_entity = what.instantiate()
	where.add_child(new_entity)
	pass
