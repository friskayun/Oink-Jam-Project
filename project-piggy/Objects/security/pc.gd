extends ObjectInteract


func _on_interact():
	DialogueManager.play_dialogue("pc")
	await DialogueManager.dialogue_ended
