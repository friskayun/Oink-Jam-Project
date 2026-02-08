extends Level

const SPAWN_DIALOGUE = "hallway_corn_factory_1"


func _ready():
	super()
	first_visit()

func first_visit():
	Global.play_cutscene()
	
	await get_tree().create_timer(2).timeout
	DialogueManager.play_dialogue(SPAWN_DIALOGUE)
	await DialogueManager.dialogue_ended
	
	Global.end_cutscene()
	TutorialScreen.show_screen()
