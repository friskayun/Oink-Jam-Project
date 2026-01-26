extends Control

@onready var timer = $PrintTimer

var dialogues: Dictionary = {}

var dialogue_id: String = ""
var curr_dialogue
var line_index: int = 0
var char_index: int = 0

var active_dialogue: bool = false
var printing_prompt: bool = false



func _ready():
	dialogues = DataManager.read_script_data()
	hide_dialogue_panel()
	timer.wait_time = 0.05

func _input(event):
	if event.is_action_pressed("advance_dialogue") and active_dialogue:
		show_next_line()
	
	if event.is_action_pressed("skip_dialogue") and active_dialogue:
		end_dialogue()

func _on_print_timer_timeout():
	animate_dialogue_line()



#region UI functions

func show_dialogue_panel():
	show()

func hide_dialogue_panel():
	hide()

func show_left_character():
	%LeftSprite.show()
	%RightSprite.hide()

func show_right_character():
	%LeftSprite.hide()
	%RightSprite.show()

func hide_character_sprites():
	%LeftSprite.hide()
	%RightSprite.hide()

func change_panel_contents(text: String, speaker: String  = ""):
	# switching between character dialogue or item description 
	if speaker == "":
		%NameLabel.hide()
		hide_character_sprites()
	else:
		%NameLabel.show()
		%NameLabel.text = speaker
		@warning_ignore("standalone_ternary")
		show_left_character() if speaker == "Player" else show_right_character()
	
	# prompt set up
	%TextLabel.text = text
	printing_prompt = true
	timer.start()
	animate_dialogue_line()

func animate_dialogue_line():
	char_index += 1
	%TextLabel.visible_characters = char_index
	if char_index > %TextLabel.text.length():
		reset_print_anim()

func reset_print_anim():
	timer.stop()
	char_index = 0
	%TextLabel.visible_characters = -1
	printing_prompt = false

#endregion


func start_dialogue(id: String):
	if active_dialogue:
		return
	
	line_index = 0
	dialogue_id = id
	curr_dialogue = dialogues[dialogue_id]
	active_dialogue = true
	Global.freeze_input = true
	show_next_line()
	show_dialogue_panel()

func show_next_line():
	if printing_prompt:
		reset_print_anim()
	
	if curr_dialogue["lines"].size() > line_index:
		print("showing next line...")
		var line = curr_dialogue["lines"][line_index]
		
		if line.has("speaker"):
			change_panel_contents(line["text"], line["speaker"])
		else:
			change_panel_contents(line["text"])
		
		line_index += 1
	else:
		print("ending...")
		end_dialogue()

func end_dialogue():
	active_dialogue = false
	Global.freeze_input = false
	hide_dialogue_panel()
