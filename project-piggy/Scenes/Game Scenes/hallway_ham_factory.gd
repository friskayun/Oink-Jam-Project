extends Level

const DIALOGUE_FIRST_VISIT = "hallway_ham_factory_visit"

@onready var anim_player = $AnimationPlayer

func _ready():
	super()
	
	level_state()

func level_state():
	if Global.curr_state == Global.GAME_STATE.LOOKING_FOR_POPPY:
		%Door_WA.first_visit = true
		unlock_storage_door(false)
		unlock_security_door(false)
		first_visit()
	elif Global.curr_state == Global.GAME_STATE.FIRST_CHASE:
		%Door_WA.first_visit = false
		unlock_storage_door(true)
		unlock_security_door(false)
	else:
		%Door_WA.first_visit = false
		unlock_storage_door(true)
		unlock_security_door(true)


func first_visit():
	Global.play_cutscene()
	
	anim_player.play("first_visit_camera")
	await anim_player.animation_finished
	$Player/Camera2D.position = Vector2.ZERO
	DialogueManager.play_dialogue(DIALOGUE_FIRST_VISIT)
	
	Global.end_cutscene()

func unlock_storage_door(unlock: bool):
	%StorageLocked.disable = unlock
	$Doors/Door_Storage.is_active = unlock

func unlock_security_door(unlock: bool):
	%SecurityLocked.disable = unlock
	$Doors/Door_Security.is_active = unlock
