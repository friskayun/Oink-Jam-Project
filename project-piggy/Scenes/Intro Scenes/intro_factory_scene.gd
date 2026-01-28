extends Node2D

const NEXT_SCENE = "intro_final_scene"

@onready var anim_player = $AnimationPlayer


func _ready():
	print("opening: intro_factory_scene")
	call_deferred("intro_cutscene")

func intro_cutscene():
	
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
	NavigationManager.go_to_level(NEXT_SCENE)
