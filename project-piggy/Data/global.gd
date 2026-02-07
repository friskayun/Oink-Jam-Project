extends Node

signal on_pick_up_item(item: Item)
signal _on_use_oil_item

var freeze_input: bool = false
var in_cutscene: bool = false
var dialogue_run: bool = false
var ui_win_shown: bool = false

var is_player_in_vent: bool = false
var used_oil_item = false

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _input(event):
	if event.is_action_pressed("screenshot"):
		var timestamp = Time.get_datetime_string_from_system(false, true).replace(":", "-")
		var ss = get_viewport().get_texture().get_image()
		ss.save_png("user://screenshot " + timestamp + ".png")
		print("saved ss")

func play_cutscene():
	in_cutscene = true

func end_cutscene():
	in_cutscene = false

func set_ui_win_status(value: bool):
	ui_win_shown = value

func get_ui_win_status():
	return ui_win_shown

func pick_up_item(item: Item):
	on_pick_up_item.emit(item)


func player_enter_vent():
	is_player_in_vent = true

func player_exit_vent():
	is_player_in_vent = false

func use_oil_item():
	used_oil_item = true
	_on_use_oil_item.emit()
