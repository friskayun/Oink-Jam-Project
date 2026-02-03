extends ObjectInteract

func _on_interact():
	DialogueManager.play_choice("fire_alarm_choice", _on_choice)

func _on_choice(index: int):
	match index:
		0:
			GameState.activate_fire_alarm()
		1:
			pass
