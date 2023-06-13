extends TextureRect

@export var check         : TextureRect
@export var value         : Label
@export var edit          : LineEdit

var check_flag := false
var edit_flag  := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func pressed() -> void:
#	edit_mode(!edit_flag)
	set_check(!check_flag)
	pass # Replace with function body.

func set_check(flag) -> void:
	check_flag = flag
	check.visible = flag
	pass

func set_value(new_value):
	value.text = str(new_value)
	pass

func edit_mode(flag):
	edit_flag = flag
	value.visible = !flag
	edit.visible  =  flag
	if flag:
		edit.text  = value.text
		edit.grab_focus()
	else:
		value.text =  edit.text
	pass


func submitted(new_text: String) -> void:
	edit_mode(false)
	pass # Replace with function body.
