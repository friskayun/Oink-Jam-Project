extends ObjectInteract

const OIL = preload("uid://naso8kxch7yx")

var got_oil: bool = false

func _on_interact():
	if got_oil:
		DialogueManager.play_dialogue("guard_cabinet_idle")
		await DialogueManager.dialogue_ended
	else:
		DialogueManager.play_dialogue("guard_cabinet_oil")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("oil_choice", _on_choice)

func _on_choice(index: int):
	match index:
		0:
			Global.pick_up_item(OIL)
			got_oil = true
		1:
			pass
