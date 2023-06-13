extends Resource

class_name skill

@export var name        : String
@export var value       : int 
@export var overcome    : String
@export var advantage   : String
@export var attack      : String
@export var defend      : String

func _init(new_name : String, new_value : int):
	name   = new_name
	value  = new_value
	pass

func change_name(new_name : String):
	name = new_name
	pass
