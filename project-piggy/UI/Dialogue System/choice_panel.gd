extends Control
class_name ChoicePanel

const CHOICE_BUTTON = preload("uid://b10rkn60a0bq")

var buttons: Array = [] 
var active_choice: bool = false

func _ready():
	DialogueManager.connect("show_choice_panel", show_panel)
	hide()

func get_button(_text: String):
	var button = CHOICE_BUTTON.instantiate()
	button.text = _text
	buttons.append(button)
	%VBoxContainer.add_child(button)

func clear_buttons():
	for c in %VBoxContainer.get_children():
		if c is Button:
			c.queue_free()
	
	buttons.clear()

func show_panel(id: String):
	if active_choice:
		return
	
	active_choice = true
	Global.freeze_input = true
	clear_buttons()
	show()
	
	var choices = DialogueManager.choices[id]
	
	%Label.text = choices["line"]
	for c in choices["choices"].size():
		get_button(choices["choices"][c]["text"])
		buttons[c].pressed.connect(func(): _on_choice_selected(c))
		
	buttons[0].call_deferred("grab_focus")

func hide_panel():
	hide()
	active_choice = false
	Global.freeze_input = false

func _on_choice_selected(index: int):
	hide_panel()
	DialogueManager._on_choice.call(index)
