extends Node2D

@onready var interact_area: InteractArea = $"Interact Area"

@export var disable: bool = false


func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if disable:
		return
	
	DialogueManager.play_dialogue("door_locked")
