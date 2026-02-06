extends ObjectInteract

@export var vent_index: int = 6
@export var scene_id: String = "guards_room"

@export var meat_worker: MeatWorker

func _ready():
	super()
	
	if GameState.is_guard_sleeping() and GameState.curr_state < GameState.STATE.UNLOCK_CAGES:
		_guard_put_to_sleep_cutscene()

func _on_interact():
	if GameState.curr_state == GameState.STATE.UNLOCK_CAGES:
		DialogueManager.play_dialogue("vent_guard_sleep_down")
		await DialogueManager.dialogue_ended
		return
	
	if Global.is_player_in_vent:
		DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
	else:
		DialogueManager.play_choice("vent_storage_choice", _vent_choice_down)
		


func _vent_choice_down(index: int):
	match index:
		0:
			if !GameState.is_fire_alarm_on() and !GameState.is_guard_in_room():
					GameState.first_visit_guard()
			
			# get guard in room, after distracted with fire alarm
			if GameState.is_fire_alarm_on():
				GameState.off_fire_alarm()
			
			# on guard put to sleep cutscene
			if GameState.are_pills_planted():
				GameState.put_guard_to_sleep()
				NavigationManager.go_to_level(scene_id, "V_Up")
				return
			
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
			if GameState.is_guard_in_room():
				DialogueManager.play_dialogue("vent_guard_up")
				await DialogueManager.dialogue_ended
				DialogueManager.play_choice("in_vent_choice", _vent_choice_up)
			else:
				Global.player_exit_vent()
				NavigationManager.go_to_level(scene_id, "V_Down")

func _guard_put_to_sleep_cutscene():
	Global.play_cutscene()
	
	await get_tree().create_timer(3).timeout
	
	if meat_worker:
		meat_worker.guard_sleep_anim()
	
	DialogueManager.play_dialogue("guard_sleep")
	await DialogueManager.dialogue_ended
	NavigationManager.go_to_level(scene_id, "V_Down")
	
	Global.end_cutscene()
	GameState.curr_state = GameState.STATE.UNLOCK_CAGES
