extends ObjectInteract


func _on_interact():
	if GameState.curr_state == GameState.STATE.UNLOCK_CAGES:
		DialogueManager.play_dialogue("guard_water_active")
		await DialogueManager.dialogue_ended
		return
	
	DialogueManager.play_dialogue("guard_water_idle")
	await DialogueManager.dialogue_ended

func use_item_action():
	
	if GameState.curr_state <= GameState.STATE.PUT_TO_SLEEP:
		GameState.curr_state = GameState.STATE.UNLOCK_CAGES
	
	DialogueManager.play_dialogue("guard_water_active")
	await DialogueManager.dialogue_ended
