extends Node2D

@onready var anim_player = $AnimationPlayer

func _ready():
	intro_cutscene()

func intro_cutscene():
	
	##fade in + walk in anim
	anim_player.play("walk_in")
	await anim_player.animation_finished
	
	## Dialogue 1 -> silence
	DialogueManager.show_dialogue_panel.emit("intro_missing_1")
	await DialogueManager.dialogue_ended
	
	## Dialogue 2 -> penny turns left
	$NPCs/Penny.look("left")
	await get_tree().create_timer(1).timeout
	DialogueManager.show_dialogue_panel.emit("intro_missing_2")
	await DialogueManager.dialogue_ended
	
	## Dialogue 3 -> penny look around
	anim_player.play("penny_look_around")
	await anim_player.animation_finished
	DialogueManager.show_dialogue_panel.emit("intro_missing_3")
	await DialogueManager.dialogue_ended
	
	## Dialogue 4 -> everyone walks out except mr horns and penny
	anim_player.play("class_walk_out")
	await get_tree().create_timer(1.5).timeout
	DialogueManager.show_dialogue_panel.emit("intro_missing_4")
	await DialogueManager.dialogue_ended
	
	# walk out + fade out
	anim_player.play("end_walk_out")
	await get_tree().create_timer(1.5).timeout
