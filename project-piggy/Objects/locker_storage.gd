extends ObjectInteract

const SCREWDRIVER = preload("uid://bqbp21mulaqaq")
var got_screwdriver: bool = false

func _on_interact():
	DialogueManager.play_dialogue("locker_storage_empty")
	await DialogueManager.dialogue_ended
	
	if !got_screwdriver:
		DialogueManager.play_dialogue("locker_storage_item")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("locker_storage_choice", _on_choice)

func _on_choice(i: int):
	match i:
		0:
			Global.pick_up_item(SCREWDRIVER)
			got_screwdriver = true
		1: 
			pass
