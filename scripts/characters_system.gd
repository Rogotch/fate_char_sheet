extends Node

var main_character : character

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_character = character.new()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_skill_by_id(id):
	for _skill in main_character.skills:
		if _skill.id == id:
			return _skill
	pass
