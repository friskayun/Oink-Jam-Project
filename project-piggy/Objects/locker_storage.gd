extends ObjectInteract

const SCREWDRIVER = preload("uid://bqbp21mulaqaq")

func _on_interact():
	DialogueManager.play_dialogue("locker_storage_idle")
	await DialogueManager.dialogue_ended
	
	if !GameState.is_item_taken(SCREWDRIVER.item_id):
		DialogueManager.play_dialogue("locker_storage_item")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("take_choice", _on_choice)

func _on_choice(i: int):
	match i:
		0:
			GameState.took_item(SCREWDRIVER.item_id)
			Global.pick_up_item(SCREWDRIVER)
		1: 
			pass
