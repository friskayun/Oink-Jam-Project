extends Node

var freeze_input: bool = false

var in_cutscene: bool = false

var curr_state: GAME_STATE = GAME_STATE.FIND_GUARDS_ROOM

enum GAME_STATE {
	LOOKING_FOR_POPPY,
	FIRST_CHASE,
	EXPLORE_SECURITY,
	FIND_GUARDS_ROOM
}


func play_cutscene():
	in_cutscene = true

func end_cutscene():
	in_cutscene = false
