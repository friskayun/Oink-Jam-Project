extends Control

const INTRO_CUTSCENE = "intro_cutscene"
const CREDITS_SCENE = "credits_screen"
@onready var switch_sfx = $SwitchSFX
@onready var press_sfx = $PressSFX
@onready var options_menu = $OptionsMenu

func _ready():
	if DataManager.load_game_data():
		%LoadButton.disabled = false
		%LoadButton.focus_mode = FOCUS_ALL
	else:
		%LoadButton.disabled = true
		%LoadButton.focus_mode = FOCUS_NONE
	
	Global.disable_focus_sfx()
	focus_first_button()
	await get_tree().process_frame
	Global.enable_focus_sfx()


func toggle_focus(enable: bool):
	for button in $VBoxContainer.get_children():
		if button is Button:
			button.focus_mode = Control.FOCUS_ALL if enable else FOCUS_NONE
	
	if !DataManager.load_game_data():
		%LoadButton.disabled = true
		%LoadButton.focus_mode = FOCUS_NONE

func focus_first_button():
	$VBoxContainer.get_child(0).call_deferred("grab_focus")


func _on_button_focus_entered():
	if !Global.focus_sfx_enabled:
		return
	
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
	options_menu.show_options_screen(self)

func _on_credits_button_pressed():
	press_sfx.play()
	NavigationManager.go_to_level(CREDITS_SCENE)

func _on_exit_button_pressed():
	press_sfx.play()
	get_tree().quit()
