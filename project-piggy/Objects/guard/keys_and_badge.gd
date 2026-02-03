extends ObjectInteract

const KEY = preload("uid://dx8f1y3dpjba2")


func _on_interact():
	DialogueManager.play_dialogue("guard_badge_idle")
	await DialogueManager.dialogue_ended
	
	if !GameState.is_item_taken(KEY.item_id):
		DialogueManager.play_dialogue("guard_badge_item")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("keys_choice", _on_choice)
	
func _on_choice(index: int):
	match index:
		0:
			GameState.took_item(KEY.item_id)
			Global.pick_up_item(KEY)
		1:
			pass
