extends Control

var dialogues: Dictionary = {}
var dialogue_id: String = ""
var curr_dialogue
var line_index: int = 0
var active_dialogue: bool = false

func _ready():
	dialogues = DataManager.read_script_data()
	hide_dialogue_panel()

func _input(event):
	## Just for testing / must delete later
	if event.is_action_pressed("interact") and !active_dialogue:
		start_dialogue("first_encounter")
	
	if event.is_action_pressed("advance_dialogue") and active_dialogue:
		show_next_line()

#region UI functions

func show_dialogue_panel():
	show()

func hide_dialogue_panel():
	hide()

func change_panel_contents(speaker: String, text: String):
	%NameLabel.text = speaker
	%TextLabel.text = text

#endregion

func start_dialogue(id: String):
	line_index = 0
	dialogue_id = id
	curr_dialogue = dialogues[dialogue_id]
	active_dialogue = true
	show_next_line()
	show_dialogue_panel()

func show_next_line():
	if curr_dialogue["lines"].size() > line_index:
		print("showing next line...")
		var line = curr_dialogue["lines"][line_index]
		change_panel_contents(line["speaker"], line["text"])
		line_index += 1
	else:
		print("ending...")
		end_dialogue()

func end_dialogue():
	active_dialogue = false
	hide_dialogue_panel()
