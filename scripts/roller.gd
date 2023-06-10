extends VBoxContainer

signal roll(value : int)

@export var pool                        : HBoxContainer
@export var info                        : Label
@export var text                        : Label
@onready var rng = RandomNumberGenerator.new()
@onready var dice_class = preload("res://entities/fate_dice.tscn")
var roll_result = 0
var skill_value = 0

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
	roll.emit(roll_result)
	pass


func _on_transparent_button_pressed() -> void:
	fate_roll()
	set_roll_text()
	pass # Replace with function body.

func set_skill(value):
	skill_value = value
	set_roll_text()
	pass

func set_roll_text():
	text.text = "{roll} + {skill} = {result}".format({"roll" : roll_result, "skill" : skill_value, "result" : skill_value + roll_result})
	pass
