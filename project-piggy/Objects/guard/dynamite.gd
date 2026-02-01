extends ObjectInteract

var lighted: bool = false

func _on_interact():
	if lighted:
		DialogueManager.play_dialogue("guard_dynamite_active")
		await DialogueManager.dialogue_ended
		return
	
	DialogueManager.play_dialogue("guard_dynamite_idle")
	await DialogueManager.dialogue_ended

func use_item_action():
	lighted = true
	DialogueManager.play_dialogue("guard_dynamite_active")
	await DialogueManager.dialogue_ended
	
