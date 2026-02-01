extends ObjectInteract

@export var vent_index: int = 2
@export var is_vent_locked: bool = true
@export var scene_id: String = "storage_scene"

func _on_interact():
	if Global.is_player_in_vent:
		DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
		return
	
	if is_vent_locked:
		_objective_locked()
	else:
		_objective_unlocked()

func use_item_action():
	is_vent_locked = false


func _objective_locked():
	DialogueManager.play_dialogue("vent_storage_locked")

func _objective_unlocked():
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
			Global.player_exit_vent()
			NavigationManager.go_to_level(scene_id, "V_Down")
