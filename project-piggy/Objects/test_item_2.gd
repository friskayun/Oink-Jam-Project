extends Sprite2D

@onready var interact_area: InteractArea = $"Interact Area"
@onready var dialogue_system = $"../CanvasLayer/Dialogue System"

var first_interaction = true

func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	DialogueManager._on_choice = _on_choice_selected
	DialogueManager.emit_signal("show_choice_panel", "choice_event")
	

func _on_choice_selected(index: int):
	match index:
		0:
			print("choose to exit")
		1:
			print("choose to stay")
