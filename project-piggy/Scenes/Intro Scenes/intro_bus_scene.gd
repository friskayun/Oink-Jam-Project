extends Node2D

const IntroFactoryScene = "res://Scenes/Intro Scenes/intro_factory_scene.tscn"

@onready var anim_player = $AnimationPlayer

signal cutscene_ended

func _ready():
	cutscene_ended.connect(_change_next_scene)
	print("opening: intro_bus_scene")
	call_deferred("intro_cutscene")

func intro_cutscene():
	anim_player.play("fade_in")
	await  anim_player.animation_finished
	anim_player.play("everyone_jump")
	await get_tree().create_timer(1).timeout
	
	DialogueManager.show_dialogue_panel.emit("intro_bus_1")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2).timeout
	
	## Silence and stillness, nothing changes here
	
	DialogueManager.show_dialogue_panel.emit("intro_bus_2")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2).timeout
	
	## Poppy raises her hand
	$NPCs/Penny.jump_anim()
	
	DialogueManager.show_dialogue_panel.emit("intro_bus_3")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2).timeout
	
	## Excitement
	DialogueManager.show_dialogue_panel.emit("intro_bus_4")
	anim_player.play("everyone_jump")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2).timeout
	
	## Poppy turns to Penny
	$NPCs/NPC.look("up")
	DialogueManager.show_dialogue_panel.emit("intro_bus_5")
	await DialogueManager.dialogue_ended
	$NPCs/NPC.look("right")
	
	## Screen fades black -> transition to next scene
	anim_player.play("fade_out")
	await  anim_player.animation_finished
	
	cutscene_ended.emit()

func _change_next_scene():
	print("changig scene...")
	get_tree().change_scene_to_file(IntroFactoryScene)
