extends ObjectInteract

@export var direction_spawn: String = "down"
@export var ending_id: String = "bad_ending_exit_hallway"
  
@onready var spawn = $Spawn

func _on_interact():
	if GameState.curr_state == GameState.STATE.GET_TO_POPPY:
		DialogueManager.play_dialogue("hallway_ham_factory_doors_interact") 
		await DialogueManager.dialogue_ended
	else:
		DialogueManager.play_dialogue("exit_hallway_door_event") 
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("exit_hallay_door_choice", _on_choice) 

func _on_choice(index: int):
	match index:
		0:
			## bad ending
			NavigationManager.go_to_level("ending_screen", ending_id)
		1: 
			## dialogue
			DialogueManager.play_dialogue("exit_hallway_door_no") 
			await DialogueManager.dialogue_ended
