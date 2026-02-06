extends Level

@onready var meat_worker = $NPCs/MeatWorker

func _ready():
	super()
	
	if !GameState.is_guard_in_room():
		meat_worker.queue_free()
	
	if GameState.curr_state < GameState.STATE.EXPLORE_CAGE_ROOM:
		GameState.curr_state = GameState.STATE.EXPLORE_CAGE_ROOM
	
	if GameState.curr_state >= GameState.STATE.UNLOCK_CAGES:
		meat_worker.guard_sleep_anim()
	
	if !GameState.is_fire_alarm_on() and !GameState.is_guard_in_room() and !Global.is_player_in_vent:
		if GameState.curr_checkpoint < GameState.CHECKPOINT.FOUND_POPPY_ROOM:
			GameState.curr_checkpoint = GameState.CHECKPOINT.FOUND_POPPY_ROOM
			GameState._save_checkpoint()
	
	if GameState.curr_state == GameState.STATE.UNLOCK_CAGES:
		if GameState.curr_checkpoint < GameState.CHECKPOINT.FREE_CAGES:
			GameState.curr_checkpoint = GameState.CHECKPOINT.FREE_CAGES
			GameState._save_checkpoint()
