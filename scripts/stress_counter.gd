extends editing_line

@export var settings    : TextureButton

var additional_params : Array[stress_params]

func select(flag):
	super.select(flag)
	settings.modulate = Color.WHITE if flag else Color.TRANSPARENT 
	pass
