extends Level

func _ready():
	super()
	
	if GameState.curr_state < GameState.STATE.EXPLORE_CAGE_ROOM:
		GameState.curr_state = GameState.STATE.EXPLORE_CAGE_ROOM
		GameState.first_visit_guard()
	
	$NPCs/Guard.visible = GameState.is_guard_in_room()
