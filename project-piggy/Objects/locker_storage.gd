extends ObjectInteract

func _on_interact():
	DialogueManager.play_dialogue("locker_storage")
	await DialogueManager.dialogue_ended
