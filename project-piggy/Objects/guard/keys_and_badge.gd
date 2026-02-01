extends ObjectInteract

const KEY = preload("uid://dx8f1y3dpjba2")

var got_keys: bool = false

func _on_interact():
	if got_keys:
		DialogueManager.play_dialogue("guard_badge_idle")
		await DialogueManager.dialogue_ended
	else:
		DialogueManager.play_dialogue("guard_badge_key")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("keys_choice", _on_choice)
	
func _on_choice(index: int):
	match index:
		0:
			Global.pick_up_item(KEY)
			got_keys = true
		1:
			pass
