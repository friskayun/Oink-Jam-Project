extends Level

const DIALOGUE_FIRST_VISIT = "hallway_ham_factory_visit"

@onready var anim_player = $AnimationPlayer

func _ready():
	super()
	level_state()

func level_state():
	if GameState.curr_state == GameState.STATE.LOOK_FOR_POPPY:
		unlock_storage_door(false)
		unlock_security_door(false)
		first_visit()
	elif GameState.curr_state == GameState.STATE.FIRST_CHASE:
		unlock_storage_door(true)
		unlock_security_door(false)
	else:
		unlock_storage_door(true)
		unlock_security_door(true)


func first_visit():
	Global.play_cutscene()
	
	anim_player.play("first_visit_camera")
	await anim_player.animation_finished
	$Player/Camera2D.position = Vector2.ZERO
	DialogueManager.play_dialogue(DIALOGUE_FIRST_VISIT)
	await DialogueManager.dialogue_ended
	
	GameState.curr_state = GameState.STATE.GET_TO_POPPY
	
	Global.end_cutscene()

func unlock_storage_door(unlock: bool):
	%StorageLocked.disable = unlock
	$Doors/Door_Storage.is_active = unlock

func unlock_security_door(unlock: bool):
	%SecurityLocked.disable = unlock
	$Doors/Door_Security.is_active = unlock
