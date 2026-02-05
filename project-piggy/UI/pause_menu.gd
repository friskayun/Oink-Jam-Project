extends Control

const INTRO_CUTSCENE = "intro_cutscene"
@onready var load_button = $VBoxContainer/LoadButton
@onready var v_box_container = $VBoxContainer

func _ready():
	setup()
	hide()

func _input(event):
	if event.is_action_pressed("skip_dialogue"):
		if Global.in_cutscene:
			return
		
		@warning_ignore("standalone_ternary")
		hide_panel() if visible else show_panel()

func setup():
	if DataManager.load_game_data():
		load_button.disabled = false
		load_button.focus_mode = FOCUS_ALL
	else:
		load_button.disabled = true
		load_button.focus_mode = FOCUS_NONE
	
	v_box_container.get_child(0).call_deferred("grab_focus")

func show_panel():
	show()
	setup()
	get_tree().paused = true
	Global.freeze_input = true

func hide_panel():
	hide()
	get_tree().paused = false
	Global.freeze_input = false


func _on_continue_button_pressed():
	hide_panel()

func _on_load_button_pressed():
	hide_panel()
	GameState._load_checkpoint()

func _on_new_button_pressed():
	hide_panel()
	GameState._on_new_game()
	NavigationManager.go_to_level("intro_cutscene")

func _on_options_button_pressed():
	pass # Replace with function body.
	hide_panel()

func _on_exit_button_pressed():
	hide_panel()
	NavigationManager.go_to_level("main_menu")
