extends Panel
class_name InventorySlot

var selected_color = "d7aacb69"
var idle_color = "271222b2"

var item: Item = null

func _ready():
	pass



func select():
	%SlotTexture.modulate = selected_color

func unselect():
	%SlotTexture.modulate = idle_color



func has_item():
	return item

func add_item(_item: Item):
	item = _item
	%ItemTexture.texture = item.item_texture

func remove_item():
	item = null
	%ItemTexture.texture = null
