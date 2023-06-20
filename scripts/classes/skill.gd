extends Resource

class_name skill

@export var name        : String     : set = set_skill_name
@export var value       : int        : set = set_value
@export var id          : int        : set = set_id

@export var overcome    : String
@export var advantage   : String
@export var attack      : String
@export var defend      : String

func _init(new_name : String, new_value : int):
	name   = new_name
	value  = new_value
	changed.connect(changed_emmit)
	pass

func change_name(new_name : String):
	name = new_name
	pass

func changed_emmit():
	SignalsBus.skills_changed.emit()
	pass

func set_skill_name(_value : String) -> void:
	name = _value
	emit_changed()
	pass

func set_value(_value : int) -> void:
	value = _value
	emit_changed()
	pass

func set_id(_value : int) -> void:
	id = _value
	emit_changed()
	pass
