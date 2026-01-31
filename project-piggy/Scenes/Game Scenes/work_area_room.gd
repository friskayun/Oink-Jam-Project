extends Level

@onready var door = $Doors/Door_Hallway

func _ready():
	super()
	visit()

func visit():
	Global.play_cutscene()
	
	DialogueManager.play_dialogue("work_area_visit")
	await DialogueManager.dialogue_ended
	
	Global.curr_state = Global.GAME_STATE.FIRST_CHASE
	Global.end_cutscene()
	NavigationManager.go_to_level(door.destination_level_tag, door.destination_door_tag)
