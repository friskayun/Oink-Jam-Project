extends Node2D

@onready var anim_player = $AnimationPlayer

func _ready():
	intro_dialogue_1()

func intro_dialogue_1():
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
	$NPCs/Poppy.jump_anim()
	
	DialogueManager.show_dialogue_panel.emit("intro_bus_3")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2).timeout
	
	## Excitement
	DialogueManager.show_dialogue_panel.emit("intro_bus_4")
	anim_player.play("everyone_jump")
	await DialogueManager.dialogue_ended
	await get_tree().create_timer(2).timeout
	
	## Penny turns to poppy
	$NPCs/NPC.look("up")
	DialogueManager.show_dialogue_panel.emit("intro_bus_5")
	await DialogueManager.dialogue_ended
	$NPCs/NPC.look("left")
	
	## Screen fades black -> transition to next scene
	anim_player.play("fade_out")
	await  anim_player.animation_finished
