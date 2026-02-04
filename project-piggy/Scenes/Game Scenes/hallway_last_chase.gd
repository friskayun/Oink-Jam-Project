extends Level

func _ready():
	super()
	level_start()

func _process(_delta):
	pass

func level_start():
	Global.play_cutscene()
	pigs_running()
	await get_tree().create_timer(1.5).timeout
	DialogueManager.play_dialogue("final_chase_start")
	await DialogueManager.dialogue_ended
	
	Global.end_cutscene()
	$NPC/Poppy.in_cage = false
	await get_tree().create_timer(1.5).timeout
	start_chase()

func start_chase():
	$NPC/MeatWorker.start_chase()
	$NPC/MeatWorker2.start_chase()
	$NPC/MeatWorker3.start_chase()

func pigs_running():
	$NPC/Pig.in_cage = false
	$NPC/Pig2.in_cage = false
	$NPC/Pig3.in_cage = false
