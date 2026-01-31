extends ObjectInteract

var is_vent_locked: bool = true

func _on_interact():
	if is_vent_locked:
		_objective_locked()
	else:
		_objective_unlocked()

func use_item_action():
	is_vent_locked = false

func _objective_locked():
	DialogueManager.play_dialogue("vent_storage_locked")

func _objective_unlocked():
	DialogueManager.play_choice("vent_storage_choice", _vent_choice)

func _vent_choice(index: int):
	match index:
		0:
			# open vent maze
			pass
		1:
			# pass / nothing happens
			pass
