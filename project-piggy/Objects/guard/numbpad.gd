extends ObjectInteract

var put_access_card: bool = false

func _on_interact():
	if put_access_card:
		return
	
	DialogueManager.play_dialogue("guard_numbpad_idle")
	await DialogueManager.dialogue_ended

func use_item_action():
	put_access_card = true
	DialogueManager.play_dialogue("guard_numbpad_active")
	await DialogueManager.dialogue_ended
	
	# everyone run animation
