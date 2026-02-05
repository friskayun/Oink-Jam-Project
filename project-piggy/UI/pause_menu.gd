extends Control

const INTRO_CUTSCENE = "intro_cutscene"

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("skip_dialogue"):
		if Global.in_cutscene or Global.freeze_input:
			return
		
		@warning_ignore("standalone_ternary")
		hide_panel() if visible else show_panel()

func show_panel():
	show()
	get_tree().paused = true
	Global.freeze_input = true

func hide_panel():
	hide()
	get_tree().paused = false
	Global.freeze_input = false

func _on_load_button_pressed():
	GameState._load_checkpoint()


func _on_new_button_pressed():
	GameState._on_new_game()
	NavigationManager.go_to_level("intro_cutscene")


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	NavigationManager.go_to_level("main_menu")
