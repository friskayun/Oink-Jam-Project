extends Control

const INTRO_CUTSCENE = "intro_cutscene"

func _ready():
	if DataManager.load_game_data():
		%LoadButton.disabled = false
		%LoadButton.focus_mode = FOCUS_ALL
	else:
		%LoadButton.disabled = true
		%LoadButton.focus_mode = FOCUS_NONE
	
	$VBoxContainer.get_child(0).call_deferred("grab_focus")

func _on_new_button_pressed():
	GameState._on_new_game()
	NavigationManager.go_to_level(INTRO_CUTSCENE)


func _on_load_button_pressed():
	
	GameState._load_checkpoint()


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_credits_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()
