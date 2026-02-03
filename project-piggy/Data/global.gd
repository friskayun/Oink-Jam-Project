extends Node

signal on_pick_up_item(item: Item)

var freeze_input: bool = false
var in_cutscene: bool = false

var is_player_in_vent: bool = false


func play_cutscene():
	in_cutscene = true

func end_cutscene():
	in_cutscene = false


func pick_up_item(item: Item):
	on_pick_up_item.emit(item)


func player_enter_vent():
	is_player_in_vent = true

func player_exit_vent():
	is_player_in_vent = false
