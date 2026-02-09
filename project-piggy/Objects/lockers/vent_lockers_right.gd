extends ObjectInteract

@export var vent_index: int = 4
@export var scene_id: String = "lockers_room"

@onready var vent_toggle_sfx = $VentToggleSFX

func _on_interact():
	if Global.is_player_in_vent:
		DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
		return
	
	DialogueManager.play_choice("vent_storage_choice", _vent_choice_down)


func _vent_choice_down(index: int):
	match index:
		0:
			# open vent maze
			vent_toggle_sfx.play()
			NavigationManager.go_to_level("vent_maze", str(vent_index))
		1:
			# pass / nothing happens
			pass

func _vent_choice_up(index: int):
	match index:
		0:
			# go back to maze
			vent_toggle_sfx.play()
			NavigationManager.go_to_level("vent_maze", str(vent_index))
		1:
			# get down to scene
			Global.player_exit_vent()
			vent_toggle_sfx.play()
			NavigationManager.go_to_level(scene_id, "V_Down")
