extends Resource

class_name skill

@export var name        : String     : set = set_skill_name
@export var value       : int        : set = set_value
@export var id          : int        : set = set_id

@export var overcome    : String
@export var advantage   : String
@export var attack      : String
@export var defend      : String

func _init(new_name = "", new_value = 0):
	name   = new_name
	value  = new_value
	check_labels()
	changed.connect(changed_emmit)
	pass


func check_labels():
	if name.is_empty():
		name = tr("BASE_SKILL_NAME")
#	if overcome.is_empty():
#		overcome = tr("BASE_SKILL_OVERCOME")
#	if advantage.is_empty():
#		advantage = tr("BASE_SKILL_ADVANTAGE")
#	if attack.is_empty():
#		attack = tr("BASE_SKILL_ATTACK")
#	if defend.is_empty():
#		defend = tr("BASE_SKILL_DEFEND")
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
