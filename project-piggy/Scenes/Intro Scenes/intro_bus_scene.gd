extends Node2D

const NEXT_SCENE = "intro_factory_scene"

@onready var anim_player = $AnimationPlayer


func _ready():
	print("opening: intro_bus_scene")
	call_deferred("intro_cutscene")

func intro_cutscene():
	#remove transition call here later -> previous switch to scene
	TransitionScene.play_fade_in_transition()
	await TransitionScene.on_transition_finished
	
	## Excited animation + Dialoguie
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
	NavigationManager.go_to_level(NEXT_SCENE)
