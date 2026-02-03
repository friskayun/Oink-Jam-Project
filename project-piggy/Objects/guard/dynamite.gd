extends ObjectInteract

func _on_interact():
	if GameState.is_dynamite_lighted():
		DialogueManager.play_dialogue("guard_dynamite_active")
		await DialogueManager.dialogue_ended
		return
	
	DialogueManager.play_dialogue("guard_dynamite_idle")
	await DialogueManager.dialogue_ended

func _on_use_item(item: Item):
	if item.item_name == required_item_name and required_item_name != "":
		if GameState.curr_state < GameState.STATE.FINAL_CHASE:
			DialogueManager.play_dialogue("guard_dynamite_use_early")
			await DialogueManager.dialogue_ended
			return false
		
		use_item_action()
		return true
	
	return false

func use_item_action():
	GameState.light_dynamite()
	DialogueManager.play_dialogue("guard_dynamite_active")
	await DialogueManager.dialogue_ended
	
