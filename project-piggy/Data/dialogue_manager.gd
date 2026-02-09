extends Node

const VNCR_PATH = "res://Data/Resources/VNC_resources/"


var dialogues: Dictionary = {}
var choices: Dictionary = {}
var vn_characters: Dictionary = {
	"Ollie": preload("uid://dh56rjlhjdvnh"),
	"Penny": preload("uid://dgr2sihp2af0v"),
	"Poppy": preload("uid://c3sitvwmdojgl"),
	"Ryan": preload("uid://vcf84m2cbfto"),
	"Mr. Horns": preload("uid://cbwkodjektpky"),
	"Tour Guide": preload("uid://c1ph1f7ybkhru"),
	"Wendy": preload("uid://ctxa2pbtksnsl"),
	"Worker": preload("uid://br5lg7w7huk0")
}

signal show_dialogue_panel(id: String)
signal show_desctiption(text: String)
signal show_choice_panel(id: String)
@warning_ignore("unused_signal")
signal dialogue_ended

@warning_ignore("unused_private_class_variable")
var _on_choice: Callable

func _ready():
	load_data()

func load_data():
	dialogues = DataManager.read_script_data(DataManager.DIALOGUE_SCRIPTS)
	choices = DataManager.read_script_data(DataManager.CHOICES_SCRIPT)


func get_vnc_resource(_character_name: String) -> VisualNovelCharacter:
	return vn_characters.get(_character_name)


func play_dialogue(dialogue_id: String):
	show_dialogue_panel.emit(dialogue_id)

func play_description(description: String):
	show_desctiption.emit(description)

func play_choice(choice_id: String, _callable: Callable):
	_on_choice = _callable
	show_choice_panel.emit(choice_id)
