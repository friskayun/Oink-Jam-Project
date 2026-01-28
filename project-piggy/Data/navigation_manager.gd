extends Node

#region Scene paths
const INTRO_BUS_SCENE = preload("res://Scenes/Intro Scenes/intro_bus_scene.tscn")
const INTRO_FACTORY_SCENE = preload("res://Scenes/Intro Scenes/intro_factory_scene.tscn")
const INTRO_FINAL_SCENE = preload("res://Scenes/Intro Scenes/intro_final_scene.tscn")
#endregion 

const STORAGE_CLOSET_ROOM = preload("res://Scenes/storage_closet_room.tscn")
const TEST_SCENE = preload("res://Scenes/test_game_scene.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag: String = ""):
	var scene_to_load = get_scene(level_tag)
	if scene_to_load != null:
		TransitionScene.play_transition()
		await TransitionScene.on_transition_finished
		if destination_tag != "":
			spawn_door_tag = destination_tag
		change_to_packed_scene(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)

func change_to_packed_scene(scene_to_load):
	get_tree().call_deferred("change_scene_to_packed", scene_to_load)

func change_to_file_scene(file_to_load):
	get_tree().call_deferred("change_scene_to_file", file_to_load)

func get_scene(scene_tag):
	match scene_tag:
		"intro_bus_scene":
			return INTRO_BUS_SCENE
		"intro_factory_scene":
			return INTRO_FACTORY_SCENE
		"intro_final_scene":
			return INTRO_FINAL_SCENE
		"storage_scene":
			return STORAGE_CLOSET_ROOM
		"test_scene":
			return TEST_SCENE
