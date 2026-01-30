extends ObjectInteract


func _on_interact():
	DialogueManager.play_dialogue("vent_security_locked")
	await DialogueManager.dialogue_ended
