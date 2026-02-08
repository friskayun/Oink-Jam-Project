extends ObjectInteract

@export var destination_level_tag: String = ""             # change to which level
@export var destination_door_tag: String = ""          # door in next level
@export var direction_spawn: String = ""
   
@onready var spawn = $Spawn
@onready var door_open_sfx = $DoorOpenSFX


func _on_interact():
	if GameState.curr_state < GameState.STATE.FIRST_CHASE:
		Global.play_track(null)
		door_open_sfx.play()
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
	else:
		DialogueManager.play_dialogue("work_area_after_visit")
