extends Sprite2D

@onready var interact_area: InteractArea = $"Interact Area"
@onready var dialogue_system = $"../CanvasLayer/Dialogue System"

var first_interaction = true

func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if first_interaction:
		dialogue_system.start_dialogue("first_encounter")
		first_interaction = false
	else:
		dialogue_system.start_dialogue("second_encounter")
