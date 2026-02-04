extends ObjectInteract


func _on_interact():
	if GameState.curr_state == GameState.STATE.FINAL_CHASE:
		return
	
	DialogueManager.play_dialogue("guard_numbpad_idle")
	await DialogueManager.dialogue_ended

func use_item_action():
	if GameState.curr_state < GameState.STATE.FINAL_CHASE:
		GameState.curr_state = GameState.STATE.FINAL_CHASE
		GameState.emit_signal("start_final_chase")
	
	DialogueManager.play_dialogue("guard_numbpad_active")
	await DialogueManager.dialogue_ended
	
	# everyone run animation
