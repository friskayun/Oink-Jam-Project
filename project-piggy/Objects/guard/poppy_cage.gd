extends ObjectInteract

func _on_interact():
	if GameState.is_first_poppy_interaction():
		GameState.complete_first_poppy_interaction()
		DialogueManager.play_dialogue("guard_cage_poppy_interaction")
	else:
		DialogueManager.play_dialogue("guard_cage_poppy_idle")
	
	await DialogueManager.dialogue_ended
