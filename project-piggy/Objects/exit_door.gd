extends ObjectInteract

@export var ending_id: String = "0"

func _on_interact():
	if Global.freeze_input:
		return
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
			await get_tree().create_timer(1).timeout
