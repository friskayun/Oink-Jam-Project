extends Node

var storage_vent_locked: bool = true


var taken_items: Array[String] = []

var curr_state: STATE

enum STATE {
	LOOK_FOR_POPPY,
	GET_TO_POPPY,
	FIRST_CHASE,
	EXPLORE_FACTORY,
	FIND_VENT,
	FIND_POPPY_ROOM,
	EXPLORE_CAGE_ROOM,
	FIND_LOCKER,
	DISTRACT_GUARD,
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


func unlock_storage_vent():
	storage_vent_locked = false

func is_storage_vent_locked():
	return storage_vent_locked
