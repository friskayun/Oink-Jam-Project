extends ObjectInteract

@export var dialogue_id: String = ""

func _on_interact():
	if GameState.curr_state >= GameState.STATE.FINAL_CHASE:
		return
	
	DialogueManager.play_dialogue(dialogue_id)
	await DialogueManager.dialogue_ended
