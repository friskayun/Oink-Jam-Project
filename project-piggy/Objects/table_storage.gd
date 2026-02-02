extends ObjectInteract

const LIGHTER = preload("uid://bctbnurjsvah2")

func _on_interact():
	DialogueManager.play_dialogue("table_storage_idle")
	await DialogueManager.dialogue_ended
	
	if !GameState.is_item_taken(LIGHTER.item_id):
		DialogueManager.play_dialogue("table_storage_item")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("take_choice", _on_choice)

func _on_choice(i: int):
	match i:
		0:
			GameState.took_item(LIGHTER.item_id)
			Global.pick_up_item(LIGHTER)
		1: 
			pass
