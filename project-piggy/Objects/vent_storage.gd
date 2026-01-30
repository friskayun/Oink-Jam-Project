extends ObjectInteract


func _on_interact():
	if Global.curr_state >= Global.GAME_STATE.FIND_GUARDS_ROOM:
		_objective_unlocked()
	else:
		_objective_locked()


func _objective_locked():
	DialogueManager.play_dialogue("vent_storage_locked")

func _objective_unlocked():
	DialogueManager.play_choice("vent_storage_choice", _vent_choice)

func _vent_choice(index: int):
	match index:
		0:
			# open vent maze
			pass
		1:
			# pass / nothing happens
			pass
