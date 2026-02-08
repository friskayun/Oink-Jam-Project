extends Level

const MEAT_WORKER = preload("uid://8ycaml5aijon")

@onready var door_sfx = $door_sfx
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
	
	player._start_moving(Vector2(16, 104))
	await player._on_stop_moving
	player._start_moving(Vector2(61, 104))
	await player._on_stop_moving
	player._start_moving(Vector2(61, 64))
	await player._on_stop_moving
	player._start_moving(Vector2(38, 64))
	await player._on_stop_moving
	player._face_direction("down")
	
	## worderk walks in -> dialogue
	door_sfx.play()
	var meat_worker = MEAT_WORKER.instantiate()
	meat_worker.global_position = Vector2(6, 104)
	$NPC.add_child(meat_worker)
	meat_worker._start_moving(144)
	await meat_worker._on_stop_moving
	
	DialogueManager.play_dialogue("storage_hide_2")
	await DialogueManager.dialogue_ended
	
	## worker walks out -> dialogue
	meat_worker._start_moving(6)
	await meat_worker._on_stop_moving
	meat_worker.queue_free()
	
	DialogueManager.play_dialogue("storage_hide_3")
	await DialogueManager.dialogue_ended
	
	
	Global.end_cutscene()
	GameState.curr_state = GameState.STATE.EXPLORE_FACTORY
	if GameState.curr_checkpoint < GameState.CHECKPOINT.FOUND_STORAGE_ROOM:
		GameState.curr_checkpoint = GameState.CHECKPOINT.FOUND_STORAGE_ROOM
		GameState._save_checkpoint()
