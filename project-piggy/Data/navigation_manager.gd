extends Node

#region Scene paths

	## Intro Scenes
const INTRO_BUS_SCENE = preload("res://Scenes/Intro Scenes/intro_bus_scene.tscn")
const INTRO_FACTORY_SCENE = preload("res://Scenes/Intro Scenes/intro_factory_scene.tscn")
const INTRO_FINAL_SCENE = preload("res://Scenes/Intro Scenes/intro_final_scene.tscn")

	## Level scenes
const HALLWAY_CORN_FACTORY = preload("res://Scenes/Game Scenes/hallway_corn_factory.tscn")
const HALLWAY_HAM_FACTORY = preload("res://Scenes/Game Scenes/hallway_ham_factory.tscn")
const WORK_AREA_ROOM = preload("res://Scenes/Game Scenes/work_area_room.tscn")
const STORAGE_CLOSET_ROOM = preload("res://Scenes/Game Scenes/storage_closet_room.tscn")
const LOCKERS_ROOM = preload("res://Scenes/Game Scenes/lockers_room.tscn")
const SECURITY_ROOM = preload("res://Scenes/Game Scenes/security_room.tscn")
const GUARDS_ROOM = preload("res://Scenes/Game Scenes/guards_room.tscn")
const VENT_MAZE = preload("uid://bg4we3alc3ufr")
const HALLWAY_LAST_CHASE = preload("uid://cxvigbgixpw6q")

	## UI Scene 
const MAIN_MENU = preload("uid://dvm87cwckmutu")
const ENDING_SCREEN = preload("uid://c1jg30hae7644")

#endregion 


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
		
		print("opening: " + level_tag)
		GameState.set_curr_scene_id(level_tag)
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
		
		# Delete test scene later 
		"test_scene":
			return TEST_SCENE
		
		"hallway_corn_factory":
			return HALLWAY_CORN_FACTORY
		"hallway_ham_factory":
			return HALLWAY_HAM_FACTORY
		"work_area_room":
			return WORK_AREA_ROOM
		"storage_scene":
			return STORAGE_CLOSET_ROOM
		"lockers_room":
			return LOCKERS_ROOM
		"security_room":
			return SECURITY_ROOM
		"guards_room":
			return GUARDS_ROOM
		"vent_maze":
			return VENT_MAZE
		"hallway_last_chase":
			return HALLWAY_LAST_CHASE
		
		"ending_screen":
			return ENDING_SCREEN
		"main_menu":
			return MAIN_MENU
