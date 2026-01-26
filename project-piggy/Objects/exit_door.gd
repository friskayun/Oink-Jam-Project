extends Node2D

@onready var interact_area: InteractArea = $"Interact Area"

func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogueManager._on_choice = _on_choice_selected
	DialogueManager.show_dialogue_panel.emit("exit_door_1")
	await DialogueManager.dialogue_ended
	DialogueManager.show_choice_panel.emit("choice_event")

func _on_choice_selected(index: int):
	match index:
		0:
			DialogueManager.show_dialogue_panel.emit("exit_door_yes")
		1:
			DialogueManager.show_dialogue_panel.emit("exit_door_no")
