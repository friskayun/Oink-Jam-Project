extends Node

var dialogues: Dictionary = {}

@warning_ignore("unused_signal")
signal show_choice_panel(id: String)
@warning_ignore("unused_signal")
signal show_dialogue_panel(id: String)
@warning_ignore("unused_signal")
signal dialogue_ended

@warning_ignore("unused_private_class_variable")
var _on_choice: Callable

func _ready():
	dialogues = DataManager.read_script_data()
