extends Control

const NEXT_SCENE = "hallway_ham_factory"
const DOOR_ID = "WA"
const KNIFE_SOUND = preload("uid://bowpnq7ichs04")

var meat_factory_dialogue: Array = [
	"work_area_visit"
]

func _ready():
	Global.play_cutscene()
	Global.play_track(KNIFE_SOUND)

	visit()

func _input(event):
	if event.is_action_pressed("cancel") and Global.in_cutscene:
		hallway()

func visit():
	for id in meat_factory_dialogue:
		await get_tree().create_timer(3).timeout
		DialogueManager.play_dialogue(id)
		await DialogueManager.dialogue_ended
	
	hallway()

func hallway():
	Global.play_track(null)
	GameState.curr_state = GameState.STATE.FIRST_CHASE
	Global.end_cutscene()
	NavigationManager.go_to_level(NEXT_SCENE, DOOR_ID)
