extends Node

const STORAGE_CLOSET_ROOM = preload("res://Scenes/storage_closet_room.tscn")
const TEST_SCENE = preload("res://Scenes/test_game_scene.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"storage_scene":
			scene_to_load = STORAGE_CLOSET_ROOM
		"test_scene":
			scene_to_load = TEST_SCENE
	
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().call_deferred("change_scene_to_packed", scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)
