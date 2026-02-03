extends Node

var storage_vent_locked: bool = true
var fire_alarm_on: bool = false
var poppy_first_interaction: bool = true
var guard_in_room: bool = true
var dynamite_lighted: bool = false

var taken_items: Array[String] = []

var curr_state: STATE = STATE.LOOK_FOR_POPPY

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
	FOUND_STORAGE_ROOM,
	FOUND_POPPY,
	FREE_CAGES
}


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
	guard_in_room = false

func is_guard_in_room():
	return guard_in_room

func light_dynamite():
	dynamite_lighted = true 

func is_dynamite_lighted():
	return dynamite_lighted

#endregion
