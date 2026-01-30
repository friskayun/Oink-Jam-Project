extends Node
class_name Level

const DOOR_NODE_PATH = "Doors/Door_"

func _ready():
	if NavigationManager.spawn_door_tag != null:
		on_level_spawn(NavigationManager.spawn_door_tag)

func on_level_spawn(destination_tag: String):
	var door_path = DOOR_NODE_PATH + destination_tag
	var door = get_node(door_path) # as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.direction_spawn)
