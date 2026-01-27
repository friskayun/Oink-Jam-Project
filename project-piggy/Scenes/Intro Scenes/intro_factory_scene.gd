extends Node2D

@onready var anim_player = $AnimationPlayer


func _ready():
	intro_dialogue_2()

func intro_dialogue_2():
	
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
