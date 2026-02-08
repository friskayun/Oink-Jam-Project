extends Panel
class_name InventorySlot

const INVENTORY_SLOT_SELECTED = preload("uid://deuhnrdwec8vl")
const INVENTORY_SLOT_UNSELECTED = preload("uid://txwfnm5e8l6i")

@onready var focus_sfx = $FocusSFX

var item: Item = null

func _ready():
	unselect()


func select():
	focus_sfx.play()
	%SlotTexture.texture = INVENTORY_SLOT_SELECTED

func unselect():
	%SlotTexture.texture = INVENTORY_SLOT_UNSELECTED


func has_item():
	return item

func add_item(_item: Item):
	item = _item
	%ItemTexture.texture = item.item_texture

func remove_item():
	item = null
	%ItemTexture.texture = null
