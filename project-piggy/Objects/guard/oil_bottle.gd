extends ObjectInteract

const OIL = preload("uid://naso8kxch7yx")

var got_oil: bool = false

func _on_interact():
	DialogueManager.play_dialogue("guard_cabinet_idle")
	await DialogueManager.dialogue_ended
	
	if !GameState.is_item_taken(OIL.item_id):
		DialogueManager.play_dialogue("guard_cabinet_oil")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("oil_choice", _on_choice)

func _on_choice(index: int):
	match index:
		0:
			GameState.took_item(OIL.item_id)
			Global.pick_up_item(OIL)
		1:
			pass
