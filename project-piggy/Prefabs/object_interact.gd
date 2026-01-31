extends Node
class_name ObjectInteract

@onready var interact_area: InteractArea = $"Interact Area"

@export var required_item_name: String  = ""

func _ready():
	interact_area.interact = Callable(self, "_on_interact")
	interact_area.use_item = Callable(self, "_on_use_item")

func _on_interact():
	pass

func _on_use_item(item: Item):
	if item.item_name == required_item_name and required_item_name != "":
		use_item_action()
		return true
	
	return false

func use_item_action():
	print("Item used.")
