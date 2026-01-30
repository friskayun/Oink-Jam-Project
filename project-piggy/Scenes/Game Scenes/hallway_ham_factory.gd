extends Level

const DIALOGUE_FIRST_VISIT = "hallway_ham_factory_visit"

@onready var anim_player = $AnimationPlayer

func _ready():
	super()
	
	level_state()

func level_state():
	if Global.curr_state == Global.GAME_STATE.LOOKING_FOR_POPPY:
		first_visit()
		unlock_storage_door(false)
	elif Global.curr_state == Global.GAME_STATE.FIRST_CHASE:
		unlock_storage_door(true)


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
