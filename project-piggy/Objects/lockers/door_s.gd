extends ObjectInteract

@export var destination_level_tag: String = ""
@export var destination_door_tag: String = ""

func _on_interact():
	if GameState.curr_state >= GameState.STATE.FINAL_CHASE:
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
		return
	
	DialogueManager.play_dialogue("lockers_door")
	await DialogueManager.dialogue_ended
