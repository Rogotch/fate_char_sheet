extends TextureRect
@export var txt: Label

func set_value(new_value : int):
	match  new_value:
		-1:
			txt.text = "-"
		0:
			txt.text = ""
		+1:
			txt.text = "+"
	pass
