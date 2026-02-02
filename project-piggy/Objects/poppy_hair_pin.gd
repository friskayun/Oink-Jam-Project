extends ObjectInteract

const HAIR_PIN = preload("uid://cquiyclkfhpy8")

func _on_interact():
	DialogueManager.play_dialogue("hallway_corn_factory_hair_pin")
	await DialogueManager.dialogue_ended
	DialogueManager.play_choice("hair_pin_choice", _on_choice)

func _on_choice(index: int):
	match index:
		0:
			GameState.took_item(HAIR_PIN.item_id)
			Global.pick_up_item(HAIR_PIN)
			queue_free()
		1: 
			pass
