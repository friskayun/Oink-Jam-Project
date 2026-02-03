extends ObjectInteract

@export var vent_index: int = 2
@export var scene_id: String = "storage_scene"

func _on_interact():
	if Global.is_player_in_vent:
		DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
		return
	
	if GameState.is_storage_vent_locked():
		objective_locked()
	elif !GameState.is_storage_vent_locked() and GameState.curr_state < GameState.STATE.FIND_VENT:
		objective_below_state()
	else:
		objective_unlocked()

func use_item_action():
	if GameState.is_storage_vent_locked():
		GameState.unlock_storage_vent()


func objective_locked():
	DialogueManager.play_dialogue("vent_storage_locked")

func objective_below_state():
	DialogueManager.play_dialogue("vent_storage_below_state")

func objective_unlocked():
	DialogueManager.play_choice("vent_storage_choice", _vent_choice_down)


func _vent_choice_down(index: int):
	match index:
		0:
			# open vent maze
			if GameState.curr_state < GameState.STATE.FIND_POPPY_ROOM:
				GameState.curr_state = GameState.STATE.FIND_POPPY_ROOM
			NavigationManager.go_to_level("vent_maze", str(vent_index))
		1:
			# pass / nothing happens
			pass

func _vent_choice_up(index: int):
	match index:
		0:
			# go back to maze
			NavigationManager.go_to_level("vent_maze", str(vent_index))
		1:
			# get down to scene
			Global.player_exit_vent()
			NavigationManager.go_to_level(scene_id, "V_Down")
