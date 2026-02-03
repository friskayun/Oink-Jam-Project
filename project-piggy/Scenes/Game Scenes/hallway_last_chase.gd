extends Level

func _ready():
	super()
	level_start()

func level_start():
	Global.play_cutscene()

	await get_tree().create_timer(1.5).timeout
	DialogueManager.play_dialogue("final_chase_start")
	await DialogueManager.dialogue_ended
	
	Global.end_cutscene()
