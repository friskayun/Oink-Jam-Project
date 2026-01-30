extends Level

@onready var anim_player = $AnimationPlayer

func _ready():
	super()
	if Global.curr_state <= Global.GAME_STATE.FIRST_CHASE:
		_first_visit()


func _first_visit():
	Global.play_cutscene()
	
	## dialogue -> penny hides 
	DialogueManager.play_dialogue("storage_hide_1")
	await DialogueManager.dialogue_ended
	anim_player.play("penny_hide")
	await anim_player.animation_finished
	
	## worderk walks in -> dialogue
	anim_player.play("worker_walk_in")
	await anim_player.animation_finished
	DialogueManager.play_dialogue("storage_hide_2")
	await DialogueManager.dialogue_ended
	
	## worker walks out -> dialogue
	anim_player.play("worker_walk_out")
	await anim_player.animation_finished
	DialogueManager.play_dialogue("storage_hide_3")
	await DialogueManager.dialogue_ended
	
	Global.curr_state = Global.GAME_STATE.EXPLORE_SECURITY
	Global.end_cutscene()
