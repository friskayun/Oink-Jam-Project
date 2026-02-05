extends Control

const INVENTORY_SLOT = preload("uid://bj03w27nhu4h6")

const GRID_ROWS = 2
const GRID_COLOMNS = 4

var is_active: bool = false

var slots: Array = []

var slot_row: int = 0
var slot_col: int = 0
var curr_slot: InventorySlot

func _ready():
	Global.on_pick_up_item.connect(add_item_to_inventory)
	GameState.connect("on_load_data", _load_inventory_items)
	
	hide()
	%GridContainer.columns = GRID_COLOMNS
	load_inventory()

func _input(event):
	if event.is_action_pressed("inventory"):
		if is_active:
			close_inventory()
		elif !is_active and !Global.freeze_input and !Global.in_cutscene:
			open_inventory()
	
	if !is_active:
		return
	
	if event.is_action_pressed("walk_up"):
		move_cursor(1, 0)
	elif event.is_action_pressed("walk_down"):
		move_cursor(-1, 0)
	elif event.is_action_pressed("walk_left"):
		move_cursor(0, -1)
	elif event.is_action_pressed("walk_right"):
		move_cursor(0, 1)
	
	if event.is_action_pressed("interact"):
		use_item()

func _load_inventory_items():
	var items = GameState.taken_items
	for id in items:
		var item = DataManager.get_item_resource_by_item_id(id)
		add_item_to_inventory(item)

func move_cursor(row: int, col: int):
	slot_row += row
	slot_col += col
	
	if slot_row < 0:
		slot_row = slots.size() - 1
	elif slot_row >= slots.size():
		slot_row = 0
	
	if slot_col < 0:
		slot_col = slots[slot_row].size() - 1
	elif slot_col >= slots[slot_row].size():
		slot_col = 0
	
	curr_slot.unselect()
	
	curr_slot = slots[slot_row][slot_col]
	curr_slot.select()
	
	set_item_details(curr_slot.has_item())


func load_inventory():
	clear_slots()
	
	for i in range(0, GRID_ROWS):
		var x_array = []
		for j in range(0, GRID_COLOMNS):
			var slot = INVENTORY_SLOT.instantiate()
			%GridContainer.add_child(slot)
			x_array.append(slot)
		
		slots.append(x_array)
	
	_load_inventory_items()
	load_select()

func clear_slots():
	for i in %GridContainer.get_children():
		i.queue_free()

func load_select():
	if curr_slot:
		curr_slot.unselect()
	
	slot_row = 0
	slot_col = 0
	curr_slot = slots[slot_row][slot_col]
	curr_slot.select()
	set_item_details(curr_slot.has_item())


func open_inventory():
	load_select()
	show()
	is_active = true
	Global.freeze_input = true
	get_tree().paused = true

func close_inventory():
	hide()
	is_active = false
	Global.freeze_input = false
	get_tree().paused = false


func add_item_to_inventory(item: Item):
	for i in range(0, GRID_ROWS):
		for j in range (0, GRID_COLOMNS):
			var slot = slots[i][j] as InventorySlot
			if slot.item == null:
				slot.add_item(item)
				return

func set_item_details(item: Item = null):
	if item:
		%ItemName.text = item.item_name
		%ItemText.text = item.item_description
	else:
		%ItemName.text = ""
		%ItemText.text = ""

func use_item():
	if curr_slot.has_item() == null:
		return
	
	var used = InteractionManager.use_item_on_active_area(curr_slot.has_item())
	
	if used:
		print("   - Item used: " + curr_slot.item.item_name)
		#curr_slot.remove_item()
		#set_item_details()
		call_deferred("close_inventory")
	else:
		print(" Item cannot be used here")
