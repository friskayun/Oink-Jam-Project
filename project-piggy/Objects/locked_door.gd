extends Node2D

@onready var interact_area: InteractArea = $"Interact Area"



func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogueManager.show_dialogue_panel.emit("door_locked")
