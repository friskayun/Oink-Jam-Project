extends Level

@onready var meat_worker = $NPC/MeatWorker
@onready var player = $Player

func _ready():
	super()
	
	if GameState.curr_state <= GameState.STATE.FIRST_CHASE:
		_first_visit()
		return


func _first_visit():
	Global.play_cutscene()
	
	await get_tree().create_timer(2).timeout
	
	## dialogue -> penny hides 
	DialogueManager.play_dialogue("storage_hide_1")
	await DialogueManager.dialogue_ended
	
	player._start_moving(Vector2(0, 32))
	await player._on_stop_moving
	player._start_moving(Vector2(0, -96))
	await player._on_stop_moving
	player._start_moving(Vector2(-64, -96))
	await player._on_stop_moving
	player._face_direction("down")
	
	## worderk walks in -> dialogue
	meat_worker._start_moving(200)
	await meat_worker._on_stop_moving
	
	DialogueManager.play_dialogue("storage_hide_2")
	await DialogueManager.dialogue_ended
	
	## worker walks out -> dialogue
	meat_worker._start_moving(-400)
	await meat_worker._on_stop_moving
	
	DialogueManager.play_dialogue("storage_hide_3")
	await DialogueManager.dialogue_ended
	
	
	Global.end_cutscene()
	GameState.curr_state = GameState.STATE.EXPLORE_FACTORY
	if GameState.curr_checkpoint < GameState.CHECKPOINT.FOUND_STORAGE_ROOM:
		GameState.curr_checkpoint = GameState.CHECKPOINT.FOUND_STORAGE_ROOM
		GameState._save_checkpoint()
