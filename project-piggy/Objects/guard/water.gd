extends ObjectInteract


func _on_interact():
	if GameState.are_pills_planted():
		DialogueManager.play_dialogue("guard_water_active")
		await DialogueManager.dialogue_ended
		return
	
	DialogueManager.play_dialogue("guard_water_idle")
	await DialogueManager.dialogue_ended

func use_item_action():
	
	if !GameState.are_pills_planted():
		GameState.plant_pills()
	
	DialogueManager.play_dialogue("guard_water_active")
	await DialogueManager.dialogue_ended
