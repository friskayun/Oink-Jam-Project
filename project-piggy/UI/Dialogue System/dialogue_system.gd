extends Control

const CHAR_WAIT_TIME = 0.03
const BLANK_WAIT_TIME = 0.04
const COMMA_WAIT_TIME = 0.10
const PERIOD_WAIT_TIME = 0.15
const EXCLAM_WAIT_TIME = 0.2

@onready var timer = $PrintTimer
@onready var anim_player = $AnimationPlayer

var dialogue_id: String = ""
var curr_dialogue
var line_index: int = 0
var char_index: int = 0
var last_speaker: String = ""
var curr_speaker: VisualNovelCharacter = null

var active_dialogue: bool = false
var printing_prompt: bool = false


func _ready():
	DialogueManager.connect("show_dialogue_panel", start_dialogue)
	hide_dialogue_panel()
	timer.wait_time = CHAR_WAIT_TIME

func _input(event):
	if event.is_action_pressed("advance_dialogue") and active_dialogue:
		if !printing_prompt:
			show_next_line()
		elif printing_prompt:
			reset_print_anim()
	
	if event.is_action_pressed("skip_dialogue") and active_dialogue:
		end_dialogue()

func _on_print_timer_timeout():
	animate_dialogue_line()


#region UI functions

func show_dialogue_panel():
	show()

func hide_dialogue_panel():
	hide()

func show_left_character(sprite_id: String = ""):
	%LeftSprite.texture = curr_speaker.get_sprite(sprite_id)
	%LeftSprite.show()
	%RightSprite.hide()
	
	if last_speaker != curr_speaker.character_name:
		anim_player.play("show_left_sprite")

func show_right_character(sprite_id: String = ""):
	%RightSprite.texture = curr_speaker.get_sprite(sprite_id)
	%LeftSprite.hide()
	%RightSprite.show()
	
	if last_speaker != curr_speaker.character_name:
		anim_player.play("show_right_sprite")

func hide_character_sprites():
	%LeftSprite.hide()
	%RightSprite.hide()

func change_panel_contents(text: String, speaker: String = "", sprite_id: String = ""):
	# switching between character dialogue or item description 
	if speaker == "":
		%NameLabel.hide()
		hide_character_sprites()
	else:
		%NameLabel.show()
		%NameLabel.text = speaker
		
		if curr_speaker and curr_speaker.character_name == speaker:
			pass
		else:
			curr_speaker = DialogueManager.get_vnc_resource(speaker)
		
		@warning_ignore("standalone_ternary")
		show_left_character(sprite_id) if speaker == "Penny" else show_right_character(sprite_id)
		
		if last_speaker != speaker:
			last_speaker = speaker
	
	# prompt set up
	%TextLabel.text = text
	printing_prompt = true
	timer.start()
	animate_dialogue_line()

func animate_dialogue_line():
	%TextLabel.visible_characters = char_index
	if char_index > %TextLabel.text.length() - 1:
		reset_print_anim()
		return
	
	char_wait_time(%TextLabel.text[char_index])
	char_index += 1

func char_wait_time(c: String):
	match c:
		".":
			timer.wait_time = PERIOD_WAIT_TIME
		",":
			timer.wait_time = COMMA_WAIT_TIME
		"!", "?":
			timer.wait_time = EXCLAM_WAIT_TIME
		" ":
			timer.wait_time = BLANK_WAIT_TIME
		_:
			timer.wait_time = CHAR_WAIT_TIME

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
	curr_dialogue = DialogueManager.dialogues[dialogue_id]
	active_dialogue = true
	Global.freeze_input = true
	show_next_line()
	show_dialogue_panel()

func show_next_line():
	if printing_prompt:
		reset_print_anim()
	
	if curr_dialogue["lines"].size() > line_index:
		#print("showing next line...")
		var line = curr_dialogue["lines"][line_index]
		
		var text = line["text"]
		var speaker = line["speaker"] if line.has("speaker") else ""
		var sprite_id = line["sprite_id"] if line.has("sprite_id") else ""
		
		change_panel_contents(text, speaker, sprite_id)
		
		#if line.has("speaker"):
			#change_panel_contents(line["text"], line["speaker"])
		#else:
			#change_panel_contents(line["text"])
		
		line_index += 1
	else:
		#print("ending...")
		end_dialogue()

func end_dialogue():
	active_dialogue = false
	Global.freeze_input = false
	hide_dialogue_panel()
	DialogueManager.emit_signal("dialogue_ended")
