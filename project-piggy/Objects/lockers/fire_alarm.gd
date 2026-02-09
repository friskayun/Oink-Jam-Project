extends ObjectInteract

@onready var alarm_sfx = $alarm_sfx

func _on_interact():
	DialogueManager.play_choice("fire_alarm_choice", _on_choice)

func _on_choice(index: int):
	match index:
		0:
			alarm_sfx.play()
			GameState.activate_fire_alarm()
		1:
			pass
