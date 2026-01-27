extends Node2D

const IntroFinalScene = "res://Scenes/Intro Scenes/intro_final_scene.tscn"

@onready var anim_player = $AnimationPlayer

signal cutscene_ended

func _ready():
	cutscene_ended.connect(_change_next_scene)
	print("opening: intro_factory_scene")
	call_deferred("intro_cutscene")

func intro_cutscene():
	
	## fade in + students walk in
	anim_player.play("fade_in")
	await anim_player.animation_finished
	anim_player.play("walk_in")
	await anim_player.animation_finished
	
	## dialogie -> silence
	DialogueManager.show_dialogue_panel.emit("intro_factory_1")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2).timeout
	
	## dialogue -> silence
	DialogueManager.show_dialogue_panel.emit("intro_factory_2")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2).timeout
	
	## penny jups
	## dialogue
	$NPCs/Penny.jump_anim()
	DialogueManager.show_dialogue_panel.emit("intro_factory_3")
	await DialogueManager.dialogue_ended
	
	## students walk out + fade out 
	anim_player.play("walk_out")
	await anim_player.animation_finished
	anim_player.play("fade_out")
	await anim_player.animation_finished
	
	cutscene_ended.emit()

func _change_next_scene():
	print("changig scene...")
	get_tree().call_deferred("change_scene_to_file", IntroFinalScene)
