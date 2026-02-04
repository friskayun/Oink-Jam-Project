extends ObjectInteract

@export var ending_id: String = "0"

func _on_interact():
	DialogueManager.play_dialogue("exit_storage_door_event")
	await DialogueManager.dialogue_ended
	DialogueManager.play_choice("exit_door_choice", _on_choice_selected)

func _on_choice_selected(index: int):
	match index:
		0:
			NavigationManager.go_to_level("ending_screen", ending_id)
		1:
			DialogueManager.play_dialogue("exit_storage_door_no")
			await DialogueManager.dialogue_ended
