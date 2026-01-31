extends ObjectInteract

const VENT_MAP = preload("uid://c4k8s22e033h6")

func _on_interact():
	DialogueManager.play_dialogue("cabinet_security")
	await DialogueManager.dialogue_ended
	DialogueManager.play_choice("cabinet_security_choice", _on_choice)


func _on_choice(i: int):
	match i:
		0:
			ItemInspect.show_item_inspect(VENT_MAP)
		1:
			pass
