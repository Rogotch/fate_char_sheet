extends Button
class_name add_button

@export var what         : PackedScene
@export var where        : Control
@export var straight_add : bool

func _ready() -> void:
	pressed.connect(straight_add_entity)
	pass

func straight_add_entity():
	if straight_add:
		add()
	pass

func add():
	var new_entity = what.instantiate()
	where.add_child(new_entity)
	pass
