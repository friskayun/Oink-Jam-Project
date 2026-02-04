extends Control

const NEXT_SCENE = "hallway_corn_factory"

const BACKOFFBUS = preload("uid://bx1ncpqiqcest")
const OUTSIDE_FACTORY = preload("uid://dbf2hfud22gfp")
const CORNFACTORY = preload("uid://uy5er4fjdl13")

@onready var rect = $TextureRect

var bus_dialogues: Array = [
	"intro_bus_1",
	"intro_bus_2",
	"intro_bus_3",
	"intro_bus_4"
]

var outside_dialogues: Array = [
	"intro_factory_1",
	"intro_factory_2",
	"intro_factory_3"
]

var factory_dialogues: Array = [
	"intro_missing_1",
	"intro_missing_2",
	"intro_missing_3"
]


func _ready():
	Global.play_cutscene()
	bus()

func _input(event):
	if event.is_action_pressed("skip_dialogue") and Global.in_cutscene:
		hallway()

func bus():
	rect.texture = BACKOFFBUS
	for id in bus_dialogues:
		await get_tree().create_timer(3).timeout
		DialogueManager.play_dialogue(id)
		await DialogueManager.dialogue_ended
	
	await get_tree().create_timer(1.5).timeout
	TransitionScene.play_transition()
	await TransitionScene.on_transition_finished
	outisde_factory()

func outisde_factory():
	rect.texture = OUTSIDE_FACTORY
	
	for id in outside_dialogues:
		await get_tree().create_timer(3).timeout
		DialogueManager.play_dialogue(id)
		await DialogueManager.dialogue_ended
	
	await get_tree().create_timer(1.5).timeout
	TransitionScene.play_transition()
	await TransitionScene.on_transition_finished
	corn_factory()

func corn_factory():
	rect.texture = CORNFACTORY
	
	for id in factory_dialogues:
		await get_tree().create_timer(3).timeout
		DialogueManager.play_dialogue(id)
		await DialogueManager.dialogue_ended
	
	await get_tree().create_timer(1.5).timeout
	hallway()

func hallway():
	Global.end_cutscene()
	NavigationManager.go_to_level(NEXT_SCENE, "Spawn")
