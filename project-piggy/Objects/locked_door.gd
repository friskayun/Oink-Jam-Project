extends ObjectInteract


@export var disable: bool = false

func _on_interact():
	if disable:
		return
	
	if GameState.curr_state == GameState.STATE.GET_TO_POPPY:
		DialogueManager.play_dialogue("hallway_ham_factory_doors_interact")
	else:
		DialogueManager.play_dialogue("door_locked")
