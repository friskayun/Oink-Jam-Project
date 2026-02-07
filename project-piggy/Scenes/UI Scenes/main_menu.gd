extends Control

const INTRO_CUTSCENE = "intro_cutscene"
@onready var switch_sfx = $SwitchSFX
@onready var press_sfx = $PressSFX

func _ready():
	if DataManager.load_game_data():
		%LoadButton.disabled = false
		%LoadButton.focus_mode = FOCUS_ALL
	else:
		%LoadButton.disabled = true
		%LoadButton.focus_mode = FOCUS_NONE
	
	$VBoxContainer.get_child(0).call_deferred("grab_focus")


func _on_button_focus_entered():
	switch_sfx.play()


func _on_new_button_pressed():
	GameState._on_new_game()
	NavigationManager.go_to_level(INTRO_CUTSCENE)
	press_sfx.play()

func _on_load_button_pressed():
	GameState._load_checkpoint()
	press_sfx.play()

func _on_options_button_pressed():
	press_sfx.play()
	pass # Replace with function body.

func _on_credits_button_pressed():
	press_sfx.play()
	pass # Replace with function body.

func _on_exit_button_pressed():
	press_sfx.play()
	get_tree().quit()
