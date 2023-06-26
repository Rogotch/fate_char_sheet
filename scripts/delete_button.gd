extends TextureButton
class_name delete_button


signal delete

@onready var delete_texture = preload("res://Sprites/Icons/cross.png")
@onready var apply_texture  = preload("res://Sprites/Icons/tick.png")
@onready var timer          = Timer.new()

var deleting_flag := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.autostart = false
	timer.timeout.connect(cancel_deleting)
	pressed.connect(delete_object)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cancel_deleting():
	set_deleting_mode(false)
	
	pass

func delete_object():
	if deleting_flag:
		delete.emit()
	else:
		set_deleting_mode(true)
	pass

func set_deleting_mode(delete_flag : bool):
	deleting_flag = delete_flag
	modulate = Color.RED if delete_flag else Color.WHITE
#	texture_normal = apply_texture if delete_flag else delete_texture
	if delete_flag:
		timer.start(3)
	pass
