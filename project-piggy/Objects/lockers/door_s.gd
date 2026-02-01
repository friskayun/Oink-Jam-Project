extends ObjectInteract

func _on_interact():
	DialogueManager.play_dialogue("lockers_door")
	await DialogueManager.dialogue_ended
