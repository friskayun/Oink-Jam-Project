extends Level

func _ready():
	super()
	
	$NPCs/Guard.visible = GameState.is_guard_in_room()
	
	if GameState.curr_state < GameState.STATE.EXPLORE_CAGE_ROOM:
		GameState.curr_state = GameState.STATE.EXPLORE_CAGE_ROOM
	
	
	if !GameState.is_fire_alarm_on() and !GameState.is_guard_in_room() and !Global.is_player_in_vent:
		if GameState.curr_checkpoint < GameState.CHECKPOINT.FOUND_POPPY_ROOM:
			GameState.curr_checkpoint = GameState.CHECKPOINT.FOUND_POPPY_ROOM
			GameState._save_checkpoint()
	
	if GameState.curr_state == GameState.STATE.UNLOCK_CAGES:
		if GameState.curr_checkpoint < GameState.CHECKPOINT.FREE_CAGES:
			GameState.curr_checkpoint = GameState.CHECKPOINT.FREE_CAGES
			GameState._save_checkpoint()
