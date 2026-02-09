extends Control

const FRONT_OF_BUS = preload("res://Assets/Backgrounds/Front of us.PNG")
const OUTSIDE_FACTORY = preload("res://Assets/Backgrounds/Outside factory.PNG")
const CORNFACTORY = preload("res://Assets/Backgrounds/Cornfactory.PNG")
const MEAT_FACTORY = preload("res://Assets/Backgrounds/Meat factory.PNG")
const MEATROOM = preload("res://Assets/Backgrounds/Meatroom.PNG")
const POPPY_MISSING = preload("res://Assets/Backgrounds/POPPY_MISSING.png")
const FINAL_SCENE = preload("res://Assets/Backgrounds/Final scene.PNG")



const INTRO_CUTSCENE = "intro_cutscene"
const CREDITS_SCENE = "credits_screen"

@onready var rect = $TextureRect

var ending_id: int = 0

var end_id: Dictionary = {
	1: {"dialogue_id": "good_ending_explosion", "BG": FINAL_SCENE},
	2: {"dialogue_id": "good_ending_default", "BG": FINAL_SCENE},
	3: {"dialogue_id": "bad_ending_exit_hallway", "BG": POPPY_MISSING},
	4: {"dialogue_id": "bad_ending_exit_storage", "BG": POPPY_MISSING},
	5: {"dialogue_id": "bad_ending_caught", "BG": MEATROOM}
}

func _ready():
	ending_id = NavigationManager.spawn_door_tag.to_int()
	Global.play_cutscene()
	cutscene()

func _input(event):
	if event.is_action_pressed("interact") and Global.in_cutscene:
		next()

func cutscene():
	Global.play_track(null)
	rect.texture = end_id[ending_id]["BG"]
	
	await get_tree().create_timer(2).timeout
	DialogueManager.play_dialogue(end_id[ending_id]["dialogue_id"])
	await DialogueManager.dialogue_ended
	
	next()

func next():
	Global.end_cutscene()
	if ending_id != 1:
		if DataManager.load_game_data():
			DialogueManager.play_choice("end_load_choice", _on_choice_load)
		else:
			DialogueManager.play_choice("end_new_choice", _on_choice_new)
	else:
		NavigationManager.go_to_level(CREDITS_SCENE)

func _on_choice_load(index: int):
	match index:
		0:
			GameState._load_checkpoint()
		1:
			NavigationManager.go_to_level("main_menu")

func _on_choice_new(index: int):
	match index:
		0:
			GameState._on_new_game()
			NavigationManager.go_to_level(INTRO_CUTSCENE)
		1:
			NavigationManager.go_to_level("main_menu")
