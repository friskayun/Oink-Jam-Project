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
	close_inventory()
	%GridContainer.columns = GRID_COLOMNS
	load_inventory()

func _input(event):
	if event.is_action_pressed("inventory"):
		if is_active:
			close_inventory()
		else:
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

func load_inventory():
	clear_slots()
	
	for i in range(0, GRID_ROWS):
		var x_array = []
		for j in range(0, GRID_COLOMNS):
			var slot = INVENTORY_SLOT.instantiate()
			%GridContainer.add_child(slot)
			x_array.append(slot)
		
		slots.append(x_array)
	
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

func open_inventory():
	load_select()
	show()
	is_active = true
	Global.freeze_input = true

func close_inventory():
	hide()
	is_active = false
	Global.freeze_input = false
