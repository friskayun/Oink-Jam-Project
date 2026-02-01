extends Control

var ending_id: String = ""

func _ready():
	ending_id = NavigationManager.spawn_door_tag
	
	await get_tree().create_timer(2).timeout
	DialogueManager.play_dialogue(ending_id)
	await DialogueManager.dialogue_ended
	
	## Start last checkpoint choice
	NavigationManager.go_to_level("main_menu")
