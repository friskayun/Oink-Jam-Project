extends ObjectInteract

var first_interaction: bool = true

func _on_interact():
	if first_interaction:
		DialogueManager.play_dialogue("guard_cage_poppy_interaction")
		first_interaction = false
	else:
		DialogueManager.play_dialogue("guard_cage_poppy_idle")
	
	await DialogueManager.dialogue_ended
