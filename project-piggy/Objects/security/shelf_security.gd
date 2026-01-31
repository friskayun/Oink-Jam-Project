extends ObjectInteract

const EMAILS = preload("uid://dchh5pek47b17")

func _on_interact():
	DialogueManager.play_dialogue("shelf_security")
	await DialogueManager.dialogue_ended
	DialogueManager.play_choice("shelf_security_choice", _on_choice)


func _on_choice(i: int):
	match i:
		0:
			ItemInspect.show_item_inspect(EMAILS)
		1:
			pass
