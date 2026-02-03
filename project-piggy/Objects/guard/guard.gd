extends ObjectInteract

const ACCESS_CARD = preload("uid://b82xkabpi757b")

func _on_interact():
	if GameState.curr_state < GameState.STATE.UNLOCK_CAGES:
		return
	
	if !GameState.is_item_taken(ACCESS_CARD.item_id):
		DialogueManager.play_dialogue("guard_card_item")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("take_choice", _on_choice)
		return
	
	DialogueManager.play_dialogue("guard_card_idle")
	await DialogueManager.dialogue_ended

func _on_choice(index: int):
	match index:
		0:
			GameState.took_item(ACCESS_CARD.item_id)
			Global.pick_up_item(ACCESS_CARD)
		1:
			pass
