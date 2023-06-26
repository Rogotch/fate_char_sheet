extends VBoxContainer

signal roll(skill_data : skill, value : int)

@export var pool                        : HBoxContainer
@export var info                        : Label
@export var text                        : Label
@onready var rng = RandomNumberGenerator.new()
@onready var dice_class = preload("res://entities/fate_dice.tscn")
var roll_result = 0
var skill_value : skill

func _ready() -> void:
#	for i in 10:
#		print(fate_roll())
	pass

func once_roll():
	rng.randomize()
	return rng.randi_range(-1,1)
	pass

func fate_roll():
	Global.delete_children(pool)
	info.visible = false
	roll_result = 0
	for i in 4:
		var result = once_roll()
		roll_result += result
		var new_dice = dice_class.instantiate()
		new_dice.set_value(result)
		pool.add_child(new_dice)
	roll.emit(skill_value, roll_result)
	pass


func _on_transparent_button_pressed() -> void:
	fate_roll()
	set_roll_text()
	pass # Replace with function body.

func set_skill(skill_data : skill):
	skill_value = skill_data
	set_roll_text()
	pass

func set_roll_text():
	var final_skill_value = 0 if skill_value == null else skill_value.value
	var skill_line = 0 if skill_value == null else skill_value.name + "(%d)" % skill_value.value
	var final_line = "{roll} + {skill} = {result}".format({"roll" : roll_result, "skill" : skill_line, "result" : final_skill_value + roll_result})
	text.text = final_line
	pass
