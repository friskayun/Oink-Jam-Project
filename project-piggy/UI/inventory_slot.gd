extends Panel
class_name InventorySlot

var selected_color = "d7aacb69"
var idle_color = "271222b2"

func _ready():
	pass

func select():
	$TextureRect.modulate = selected_color

func unselect():
	$TextureRect.modulate = idle_color
