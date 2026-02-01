extends ObjectInteract

@export var vent_index: int = 6
@export var scene_id: String = "guards_room"

func _on_interact():
	if Global.is_player_in_vent:
		DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
	else:
		DialogueManager.play_choice("vent_storage_choice", _vent_choice_down)
		


func _vent_choice_down(index: int):
	match index:
		0:
			# open vent maze
			NavigationManager.go_to_level("vent_maze", str(vent_index))
		1:
			# pass / nothing happens
			pass

func _vent_choice_up(index: int):
	match index:
		0:
			# go back to maze
			NavigationManager.go_to_level("vent_maze", str(vent_index))
		1:
			# get down to scene
			if Global.is_guard_in_room:
				DialogueManager.play_dialogue("vent_guard_up")
				await DialogueManager.dialogue_ended
				DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
			else:
				Global.player_exit_vent()
				NavigationManager.go_to_level(scene_id, "V_Down")
