extends Node2D

@onready var interact_area: InteractArea = $"Interact Area"

var ending_id = "bad_ending_exit"

func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogueManager.play_dialogue("exit_door_event")
	await DialogueManager.dialogue_ended
	DialogueManager.play_choice("exit_door_choice", _on_choice_selected)

func _on_choice_selected(index: int):
	match index:
		0:
			# switch to ending scene -> bad ending
			#DialogueManager.play_dialogue("exit_door_yes")
			NavigationManager.go_to_level("ending_screen", ending_id)
		1:
			DialogueManager.play_dialogue("exit_door_no")
			await DialogueManager.dialogue_ended
