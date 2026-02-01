extends ObjectInteract

const SLEEPING_PILLS = preload("uid://bqfep7s4a6du5")
@export var locker_num: String = "001"

var picked_item: bool = false

func _on_interact():
	DialogueManager.play_dialogue("locker_locked")

func use_item_action():
	if picked_item:
		DialogueManager.play_dialogue("guard_locker_unlock")
		await DialogueManager.dialogue_ended
		return
	
	DialogueManager.play_dialogue("guard_locker_unlock_item")
	await DialogueManager.dialogue_ended
	DialogueManager.play_choice("pills_choice", _on_choice)

func _on_choice(index: int):
	match index:
		0:
			picked_item = true
			Global.pick_up_item(SLEEPING_PILLS)
		1: 
			pass
