extends Node

signal on_pick_up_item(item: Item)

var freeze_input: bool = false
var in_cutscene: bool = false

var curr_state: GAME_STATE = GAME_STATE.FIND_PENNY

enum GAME_STATE {
	LOOKING_FOR_POPPY,
	FIRST_CHASE,
	FIND_PENNY
}


func play_cutscene():
	in_cutscene = true

func end_cutscene():
	in_cutscene = false


func pick_up_item(item: Item):
	on_pick_up_item.emit(item)
