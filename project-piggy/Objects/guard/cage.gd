extends ObjectInteract

@export var dialogue_id: String = ""

func _on_interact():
	DialogueManager.play_dialogue(dialogue_id)
	await DialogueManager.dialogue_ended
