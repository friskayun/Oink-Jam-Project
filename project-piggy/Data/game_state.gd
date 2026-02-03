extends Node

signal on_save_data
signal on_load_data

var player_global_pos: Vector2
var curr_scene_id: String

var storage_vent_locked: bool = true
var fire_alarm_on: bool = false
var poppy_first_interaction: bool = true
var guard_in_room: bool = false
var dynamite_lighted: bool = false
var guard_sleeping: bool = false
var pills_planted: bool = false

var taken_items: Array[String] = []
var curr_state: STATE = STATE.LOOK_FOR_POPPY
var curr_checkpoint: CHECKPOINT = CHECKPOINT.NONE

enum STATE {
	LOOK_FOR_POPPY,
	GET_TO_POPPY,
	FIRST_CHASE,
	EXPLORE_FACTORY,
	FIND_VENT,
	FIND_POPPY_ROOM,
	EXPLORE_CAGE_ROOM,
	FIND_LOCKER,
	PUT_TO_SLEEP,
	UNLOCK_CAGES,
	FINAL_CHASE
}

enum CHECKPOINT {
	NONE,
	FOUND_STORAGE_ROOM,
	FOUND_POPPY_ROOM,
	FREE_CAGES
}


func set_curr_scene_id(scene_id: String):
	curr_scene_id = scene_id

func get_curr_scene_id():
	return curr_scene_id

func set_player_global_pos(pos: Vector2 = Vector2.ZERO):
	player_global_pos = pos

func get_player_global_pos():
	return player_global_pos

func took_item(item_id: String):
	taken_items.append(item_id)

func is_item_taken(item_id: String):
	return taken_items.has(item_id)

#region level states

func unlock_storage_vent():
	storage_vent_locked = false

func is_storage_vent_locked():
	return storage_vent_locked

func activate_fire_alarm():
	change_guard_status(false)
	fire_alarm_on = true

func off_fire_alarm():
	change_guard_status(true)
	fire_alarm_on = false

func is_fire_alarm_on():
	return fire_alarm_on

func complete_first_poppy_interaction():
	poppy_first_interaction = false

func is_first_poppy_interaction():
	return poppy_first_interaction

func change_guard_status(value: bool):
	guard_in_room = value

func first_visit_guard():
	guard_in_room = true

func is_guard_in_room():
	return guard_in_room

func light_dynamite():
	dynamite_lighted = true 

func is_dynamite_lighted():
	return dynamite_lighted

func put_guard_to_sleep():
	guard_sleeping = true

func is_guard_sleeping():
	return guard_sleeping

func plant_pills():
	pills_planted = true

func are_pills_planted():
	return pills_planted

#endregion

func _on_new_game():
	NavigationManager.spawn_door_tag = null
	
	curr_state = STATE.LOOK_FOR_POPPY
	curr_checkpoint = CHECKPOINT.NONE
	taken_items = []
	
	player_global_pos = Vector2.ZERO
	curr_scene_id = ""

	storage_vent_locked = true
	fire_alarm_on = false
	poppy_first_interaction = true
	guard_in_room = false
	dynamite_lighted = false
	guard_sleeping = false
	pills_planted = false

func _save_checkpoint():
	on_save_data.emit()
	var data = parse_data_to_dic()
	DataManager.save_game_data(data)
	
	print("Saved...")
	print(data)
	set_player_global_pos()

func _load_checkpoint():
	var dic = DataManager.load_game_data()
	if dic != null:
		print("Loading...")
		print(dic)
		parse_dic_to_data(dic)
		on_load_data.emit()
		NavigationManager.spawn_door_tag = null
		NavigationManager.go_to_level(curr_scene_id)

func parse_data_to_dic():
	
	var dic: Dictionary = {
		"curr_state": -1,
		"curr_checkpoint": -1,
		"taken_items": [],
		"player_global_pos": Vector2.ZERO,
		"curr_scene_id": "",
		"inventory_items": [],
		"storage_vent_locked": false,
		"fire_alarm_on": false,
		"poppy_first_interaction": false,
		"guard_in_room": false,
		"dynamite_lighted": false,
		"guard_sleeping": false,
		"pills_planted": false
	}
	
	dic.curr_state = curr_state
	dic.curr_checkpoint = curr_checkpoint
	dic.taken_items = taken_items
	
	dic.player_global_pos = player_global_pos
	dic.curr_scene_id = curr_scene_id
	
	dic.storage_vent_locked = storage_vent_locked
	dic.fire_alarm_on = fire_alarm_on
	dic.poppy_first_interaction = poppy_first_interaction
	dic.guard_in_room = guard_in_room
	dic.dynamite_lighted = dynamite_lighted
	dic.guard_sleeping = guard_sleeping
	dic.pills_planted = pills_planted
	
	return dic

func parse_dic_to_data(dic: Dictionary):
	curr_state = dic.curr_state
	curr_checkpoint = dic.curr_checkpoint
	taken_items = dic.taken_items
	
	player_global_pos = dic.player_global_pos
	curr_scene_id = dic.curr_scene_id
	
	storage_vent_locked = dic.storage_vent_locked
	fire_alarm_on = dic.fire_alarm_on
	poppy_first_interaction = dic.poppy_first_interaction
	guard_in_room = dic.guard_in_room
	dynamite_lighted = dic.dynamite_lighted
	guard_sleeping = dic.guard_sleeping
	pills_planted = dic.pills_planted
