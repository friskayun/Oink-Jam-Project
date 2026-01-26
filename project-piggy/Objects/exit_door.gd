extends Node2D

@onready var interact_area: InteractArea = $"Interact Area"
@onready var dialogue_system = $"../CanvasLayer/Dialogue System"

func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	dialogue_system.start_dialogue("exit_door")
