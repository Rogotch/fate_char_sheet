extends Control

@export (NodePath) var _PopUpWin
@export (NodePath) var _PopUpSaveWin
@export (NodePath) var _MainImage
@export (NodePath) var _CroppedImage
@export (NodePath) var _Border
@export (NodePath) var _ButtonTL
@export (NodePath) var _ButtonTR
@export (NodePath) var _ButtonDL
@export (NodePath) var _ButtonDR

@onready var PopUpWin       = get_node(_PopUpWin)
@onready var PopUpSaveWin   = get_node(_PopUpSaveWin)
@onready var MainImage      = get_node(_MainImage)
@onready var CroppedImage   = get_node(_CroppedImage)
@onready var Border         = get_node(_Border)
@onready var ButtonTL       = get_node(_ButtonTL)
@onready var ButtonTR       = get_node(_ButtonTR)
@onready var ButtonDL       = get_node(_ButtonDL)
@onready var ButtonDR       = get_node(_ButtonDR)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pressedBorder
var loadedImage
#var startPosition = Vector2.ZERO
var deltaVector

var BorderStart
var BorderEnd
var BorderTopRight
var BorderDownLeft
var finalImage

var SelectedButton
var resizeFlag = false
var finalBorderRect
var BorderAnchor
var BorderAnchorKey
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if resizeFlag:
		ChangeSize()
	pass


func _on_FileDialog_file_selected(path):
	loadedImage = Image.new()
	loadedImage.load(path)
#	image.crop(300, 300)
	var strtTexture = ImageTexture.new()
	strtTexture.create_from_image(loadedImage)
	
	MainImage.texture = strtTexture
	SetImageByBorder()
	pass # Replace with function body.

func _input(event):
	if loadedImage != null:
		if event is InputEventMouseButton:
			if Border.get_global_rect().has_point(event.position):
	#			print("Pressed1")
				if event.pressed:
					pressedBorder = true
	#				print("Pressed2")
	#				StartPressPoint = event.position
					deltaVector = Border.global_position - event.position
	#			else:
			if !event.pressed && pressedBorder:
				pressedBorder = false
				deltaVector = Vector2.ZERO
			pass
		if pressedBorder && event is InputEventMouseMotion:
	#		var dragValue = Vector2((DragPanel.rect_position.x + (deltaVector.x + event.position.x) * (0.99 - (percentValue if percentValue < 1 else 1))), startPosition.y)
	#		var dragValue = Vector2((deltaVector + event.position).x * 0.5, startPosition.y)
			var dragValue = deltaVector + event.position
			Border.set_position(dragValue)
			SetImageByBorder()
	pass

func SetImageByBorder():
	var index = 1
	var loadedSize = loadedImage.get_size()
	if loadedSize.x > loadedSize.y:
		index = loadedSize.x / MainImage.size.x
	else:
		index = loadedSize.y / MainImage.size.y
#	print(index)
#	print(MainImage.rect_size)
	var borderRect = Border.get_global_rect()
#	borderRect = Rect2(0,0,0,0)
	borderRect.position *= index
	borderRect.size *= index
	
	BorderStart = borderRect.position
	BorderEnd = Border.get_end() * index
	BorderTopRight = Vector2(BorderEnd.x, BorderStart.y)
	BorderDownLeft = Vector2(BorderStart.x, BorderEnd.y)
	
	finalImage = loadedImage.get_rect(borderRect)
	var texture = ImageTexture.new()
	texture.create_from_image(finalImage)
	CroppedImage.texture = texture
	pass

func ChangeSize():
#	resizeOffset = GetOffset(ButtonDR)
#	print(get_global_mouse_position() + resizeOffset - Border.rect_position)
	if loadedImage != null:
		var offsets = get_global_mouse_position()  - ((SelectedButton.size - SelectedButton.pivot_offset) / 2)
		finalBorderRect = GetRectBetweenDots(BorderAnchor, offsets)
		SetPortrait()
	#	finalBorderRect.size.x = finalBorderRect.size.y / 4 * 3
		SetImageByBorder()
	pass

func GetOffset(button):
	var offset = get_global_mouse_position() - button.global_position + button.pivot_offset
	return offset
	pass


func ResizeOff():
	resizeFlag = false
	pass

func _on_DR_button_down():
	SelectedButton = ButtonDR
	BorderAnchor = Border.global_position
	BorderAnchorKey = Vector2(0, 0)
	resizeFlag = true
	pass # Replace with function body.


func _on_TL_button_down():
	SelectedButton = ButtonTL
	
	BorderAnchor = Vector2(Border.global_position.x + Border.size.x, Border.global_position.y + Border.size.y)
	BorderAnchorKey = Vector2(1, 1)
	
	resizeFlag = true
	pass # Replace with function body.


func _on_DL_button_down():
	SelectedButton = ButtonDL
	
	BorderAnchor = Vector2(Border.global_position.x + Border.size.x, Border.global_position.y )
	BorderAnchorKey = Vector2(1, 0)
	
	resizeFlag = true
	pass # Replace with function body.


func _on_TR_button_down():
	SelectedButton = ButtonTR
	BorderAnchor = Vector2(Border.global_position.x, Border.global_position.y + Border.size.y)
	BorderAnchorKey = Vector2(0, 1)
	resizeFlag = true
	pass # Replace with function body.


func GetRectBetweenDots(dot1, dot2):
	var rStart = Vector2(dot1.x if dot1.x < dot2.x else dot2.x, dot1.y if dot1.y < dot2.y else dot2.y)
	var rEnd   = Vector2(dot1.x if dot1.x > dot2.x else dot2.x, dot1.y if dot1.y > dot2.y else dot2.y)
#	print("Rect",  Rect2(rStart, rEnd-rStart))
	return Rect2(rStart, rEnd-rStart)
	pass

func SetPortrait():
	finalBorderRect.size.x = finalBorderRect.size.y / 4 * 3
	
	Border.size = finalBorderRect.size
	Border.position = finalBorderRect.position
	
	match BorderAnchorKey:
		Vector2(0,0):
			pass
		Vector2(1,0):
			if Border.global_position.x + Border.size.x != BorderAnchor.x:
				Border.global_position.x = BorderAnchor.x - Border.size.x
				pass
			pass
		Vector2(0,1):
			if Border.global_position.y + Border.size.y != BorderAnchor.y:
				Border.global_position.y = BorderAnchor.y - Border.size.y
				pass
			pass
			pass
		Vector2(1,1):
			if Border.global_position.x + Border.size.x != BorderAnchor.x:
				Border.global_position.x = BorderAnchor.x - Border.size.x
				pass
			pass
			if Border.global_position.y + Border.size.y != BorderAnchor.y:
				Border.global_position.y = BorderAnchor.y - Border.size.y
				pass
			pass
			pass
	pass

func _on_Load_pressed():
	PopUpWin.set_current_dir(PopUpWin.current_dir)
#	PopUpWin.update()
	PopUpWin.popup_centered()
	pass # Replace with function body.


func _on_Save_pressed():
	PopUpSaveWin.set_current_dir(PopUpSaveWin.current_dir)
	PopUpSaveWin.popup_centered()
	pass # Replace with function body.


func _on_FileDialog2_file_selected(path):
	var saveError = finalImage.save_png(path)
	print(saveError)
	pass # Replace with function body.


func _on_Save2_pressed():
	SaveSystem.save_data = {image = finalImage.data}
#	SaveSystem.save_data.image.data.compress(2)
	
	SaveSystem.call_deferred("save_game")
	pass # Replace with function body.


func _on_Load2_pressed():
#	print(SaveSystem.save_data)
	if SaveSystem.save_data != null:
		var img = SaveSystem.save_data.image
		var loadedImage = Image.new()
		match img.format:
			"RGB8":
				img.format = Image.FORMAT_RGB8
#		var bArray = PoolByteArray(img.data)
#		bArray.decompress(30000, 2)
		print(typeof(img.data) == TYPE_STRING)
		loadedImage.create_from_data(img.width, img.height, img.mipmaps, Image.FORMAT_RGB8, Array(img.data))
		var texture = ImageTexture.new()
		texture.create_from_image(finalImage)
		CroppedImage.texture = texture
	pass # Replace with function body.
