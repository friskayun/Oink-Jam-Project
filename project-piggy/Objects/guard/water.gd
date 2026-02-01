extends ObjectInteract

var put_sleeping_pills: bool = false


func _on_interact():
	if put_sleeping_pills:
		DialogueManager.play_dialogue("guard_water_active")
		await DialogueManager.dialogue_ended
		return
	
	DialogueManager.play_dialogue("guard_water_idle")
	await DialogueManager.dialogue_ended

func use_item_action():
	put_sleeping_pills = true
	DialogueManager.play_dialogue("guard_water_active")
	await DialogueManager.dialogue_ended
	
	# transition player to vent
