extends ObjectInteract

@export var vent_index: int = 2

@onready var vent_toggle_sfx = $VentToggleSFX

func _on_interact():
	if Global.is_player_in_vent:
		DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
		return
	
	DialogueManager.play_dialogue("vent_security_down")
	await DialogueManager.dialogue_ended

func _vent_choice_up(index: int):
	match index:
		0:
			# go back to maze
			vent_toggle_sfx.play()
			NavigationManager.go_to_level("vent_maze", str(vent_index))
		1:
			# can't get down / too high
			DialogueManager.play_dialogue("vent_security_up")
			await DialogueManager.dialogue_ended
			DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
