extends Node

const VNCR_PATH = "res://Data/Resources/VNC_resources/"


var dialogues: Dictionary = {}
var vn_characters = []

@warning_ignore("unused_signal")
signal show_choice_panel(id: String)
@warning_ignore("unused_signal")
signal show_dialogue_panel(id: String)
@warning_ignore("unused_signal")
signal dialogue_ended

@warning_ignore("unused_private_class_variable")
var _on_choice: Callable

func _ready():
	load_data()

func load_data():
	dialogues = DataManager.read_script_data()
	vn_characters = DataManager.fetch_resources(VNCR_PATH)

func get_vnc_resource(_character_name: String) -> VisualNovelCharacter:
	var res = vn_characters.find_custom(func(c): return c.character_name == _character_name)
	if res != -1:
		print("Found resource for \"" + _character_name + "\".")
		return vn_characters[res]
	else:
		print("Resouce for \"" + _character_name + "\" not found.")
		return null
