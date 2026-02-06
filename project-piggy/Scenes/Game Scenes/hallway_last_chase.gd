extends Level

const OIL_AREA = preload("uid://dtcsgcx4pe1eq")
@onready var player = $Player
@onready var objects = $Objects

func _ready():
	super()
	level_start()
	Global._on_use_oil_item.connect(_use_oil)
	Global.used_oil_item = false

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

func _use_oil():
	var area = OIL_AREA.instantiate()
	area.global_position = player.global_position
	objects.add_child(area)
