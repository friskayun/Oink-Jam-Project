extends ObjectInteract

func _on_interact():
	DialogueManager.play_dialogue("shelf_security")
	await DialogueManager.dialogue_ended
