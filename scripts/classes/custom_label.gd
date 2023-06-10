@tool
extends Label
class_name CustomLabel

var fonts = [
	"res://Fonts/SofiaSans-Black.ttf",
	"res://Fonts/SofiaSans-Bold.ttf",
	"res://Fonts/SofiaSans-Regular.ttf",
	"res://Fonts/SofiaSans-Thin.ttf",
	"res://Fonts/cc.yal.6w3.ttf"

]

#var keys = ["NunitoSans-Regular", "NunitoSans-ExtraLight", "SourceSansPro-Regular", "SourceSansPro-ExtraLight", "DwarvenStonecraftCyr", "Skandal"]
@export var font_size: int = 14          : set = setFontSize
@export var font_outline_color: Color    : set = SetOutlineColor
@export var font_outline_size: int = 0 : set = SetOutlineSize
@export_enum(
"SofiaSans-Black",
"SofiaSans-Bold",
"SofiaSans-Regular",
"SofiaSans-Thin",
"cc.yal.6w3") var type : int : set = setFontType

var Text = "" : get = GetLabelText, set = SetLabelText
var newFont = null

func SetLabelText(newText):
	set_text(str(newText))
	Text = newText
	pass

func GetLabelText():
	return text
	pass

func SetOutlineColor(color):
	font_outline_color = color
	setFontParams()
	pass

func SetOutlineSize(size):
	font_outline_size = size
	setFontParams()
	pass

func setFontParams():
	if type == null:
		type = 0
	newFont = FontFile.new()
#	newFont.antialiased = true
	newFont.outline_color = font_outline_color
	newFont.outline_size = font_outline_size
	newFont.font_data = load(fonts[type]).duplicate()
#	newFont.font_data.antialiased = false
	newFont.size = font_size

	add_theme_font_override("font", newFont)
	pass

func setFontSize(value):
	font_size = value
	setFontParams()
	pass

func setFontType(value):
	type = value
	setFontParams()
	pass
