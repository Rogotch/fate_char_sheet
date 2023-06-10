@tool
extends RichTextLabel

class_name CustomRichTextLabel

var fontsDictionary = {
	"SofiaSans-Black"    : "res://Fonts/SofiaSans-Black.ttf",
	"SofiaSans-Bold"     : "res://Fonts/SofiaSans-Bold.ttf",
	"SofiaSans-Regular"  : "res://Fonts/SofiaSans-Regular.ttf",
	"SofiaSans-Thin"     : "res://Fonts/SofiaSans-Thin.ttf",
	"cc.yal.6w3"         : "res://Fonts/cc.yal.6w3.ttf"
}

#var fonts = 

#var fonts = [
#	"res://Fonts/Norse.otf",
#	"res://Fonts/NorseBold.otf"
#
#]
#var keys = ["NunitoSans-Regular", "NunitoSans-ExtraLight", "SourceSansPro-Regular", "SourceSansPro-ExtraLight", "DwarvenStonecraftCyr", "Skandal"]
@export var font_size: int = 14        : set = setFontSize
@export var font_outline_color: Color    : set = SetOutlineColor
@export var font_outline_size: int = 0 : set = SetOutlineSize


var Text = "" : set = SetLabelText
var newFont = null

#var my_property = 0

var TypeNormalFont     = "cc.yal.6w3"  : set = setNormalFontParams
var TypeBoldFont       = "cc.yal.6w3"  : set = setBoldFontParams
var TypeBoldItalicFont = "cc.yal.6w3"  : set = setBoldItalicFontParams
var TypeItalicFont     = "cc.yal.6w3"  : set = setItalicFontParams
var TypeMonoFont       = "cc.yal.6w3"  : set = setMonoFontParams

#func _get_property_list():
#	var properties = []
#	# Same as "export var my_property: int"
#	properties.append({
#		name = "my_property",
#		type = TYPE_INT
#	})
#	return properties

func _get_property_list():
	var ret = []
	ret.push_back({"name": "TypeNormalFont", "type": TYPE_STRING, "usage" : PROPERTY_USAGE_DEFAULT, "hint": 3, "hint_string": getAllfonts()})
	ret.push_back({"name": "TypeBoldFont", "type": TYPE_STRING, "usage" : PROPERTY_USAGE_DEFAULT, "hint": 3, "hint_string": getAllfonts()})
	ret.push_back({"name": "TypeBoldItalicFont", "type": TYPE_STRING, "usage" : PROPERTY_USAGE_DEFAULT, "hint": 3, "hint_string": getAllfonts()})
	ret.push_back({"name": "TypeItalicFont", "type": TYPE_STRING, "usage" : PROPERTY_USAGE_DEFAULT, "hint": 3, "hint_string": getAllfonts()})
	ret.push_back({"name": "TypeMonoFont", "type": TYPE_STRING, "usage" : PROPERTY_USAGE_DEFAULT, "hint": 3, "hint_string": getAllfonts()})
#	ret.push_back({"name": "my_property", "type": TYPE_INT, "hint": 3, "hint_string": "Hello,Something,Else"})
	return ret

func getAllfonts() -> String:
	var allFontsString = ""
	var count = 0
	for font in fontsDictionary.keys():
		allFontsString += font
		if count != fontsDictionary.size() - 1:
			allFontsString += ","
		count += 1
	return allFontsString
	pass

func _ready():
#	print(text)
#	var friendFormating = Scripts._bbc_AddShakeString("Друг", 13, 13)
#	friendFormating = Scripts._bbc_AddClicable(friendFormating, {tap = true})
#	SetLabelText("Давно не виделись, мой старый добрый " + friendFormating)
#	set_text("Давно не виделись, мой старый добрый ")
#	append_bbcode(AddShakeString("Друг"))
#	set_bbcode("Давно не виделись, мой старый добрый "+AddShakeString("Друг"))
#	setAllFontParams()
#	setFontParams()
	pass

func SetLabelText(newText):
	if bbcode_enabled:
		set_bbcode(str(newText)) 
	else:
		set_text(str(newText))
	Text = text
#	prints("newText", newText)
#	text = newText
#	bbcode_enabled = true
	pass

#func GetLabelText():
#	return text
#	pass

func SetOutlineColor(color):
	font_outline_color = color
	setAllFontParams()
#	setFontParams()
	pass

func SetOutlineSize(size):
	font_outline_size = size
	setAllFontParams()
#	setFontParams()
	pass

#func setFontParams():
#	if TypeNormalFont == null:
#		type = 0
#	newFont = FontFile.new()
##	newFont.antialiased = true
#	newFont.outline_color = font_outline_color
#	newFont.outline_size = font_outline_size
#	newFont.font_data = load(fonts[type]).duplicate()
##	newFont.font_data.antialiased = false
#	newFont.size = font_size
#	add_theme_font_override("bold_font", newFont)
#	add_theme_font_override("bold_italics_font", newFont)
#	add_theme_font_override("italics_font", newFont)
#	add_theme_font_override("mono_font", newFont)
#	add_theme_font_override("normal_font", newFont)
#	pass

func getFontParam(fontKey) -> FontFile:
	newFont = FontFile.new()
#	newFont.antialiased = true
	newFont.outline_color = font_outline_color
	newFont.outline_size = font_outline_size
	newFont.font_data = load(fontsDictionary[fontKey]).duplicate()
#	newFont.font_data.antialiased = false
	newFont.size = font_size
	return newFont
	pass

func setNormalFontParams(newValue = null):
	if newValue == null:
		newValue = fontsDictionary.keys()[0]
	TypeNormalFont = newValue
	add_theme_font_override("normal_font", getFontParam(TypeNormalFont))
	pass

func setBoldFontParams(newValue = null):
	if newValue == null:
		newValue = fontsDictionary.keys()[0]
	TypeBoldFont = newValue
	add_theme_font_override("bold_font", getFontParam(TypeBoldFont))
	pass

func setBoldItalicFontParams(newValue = null):
	if newValue == null:
		newValue = fontsDictionary.keys()[0]
	TypeBoldItalicFont = newValue
	add_theme_font_override("bold_italics_font", getFontParam(TypeBoldItalicFont))
	pass

func setItalicFontParams(newValue = null):
	if newValue == null:
		newValue = fontsDictionary.keys()[0]
	TypeItalicFont = newValue
	add_theme_font_override("italics_font", getFontParam(TypeItalicFont))
	pass

func setMonoFontParams(newValue = null):
	if newValue == null:
#		print("newValueBefore", newValue)
		newValue = fontsDictionary.keys()[0]
#		print("newValueAfter", newValue)
		
	TypeMonoFont = newValue
	add_theme_font_override("mono_font", getFontParam(TypeMonoFont))
	pass

func setAllFontParams():
	setNormalFontParams(TypeNormalFont)
	setBoldFontParams(TypeBoldFont)
	setBoldItalicFontParams(TypeBoldItalicFont)
	setItalicFontParams(TypeItalicFont)
	setMonoFontParams(TypeMonoFont)
	pass

func setFontSize(value):
	font_size = value
	setAllFontParams()
#	setFontParams()
	pass

func setFontType(value):
#	type = value
#	setFontParams()
	pass
