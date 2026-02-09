extends Control

const INTRO_CUTSCENE = "intro_cutscene"
@onready var load_button = $VBoxContainer/LoadButton
@onready var v_box_container = $VBoxContainer
@onready var switch_sfx = $SwitchSFX
@onready var press_sfx = $PressSFX
@onready var options_menu = $OptionsMenu

func _ready():
	Global.disable_focus_sfx()
	
	setup()
	hide()
	
	await get_tree().process_frame
	Global.enable_focus_sfx()

func _input(event):
	if event.is_action_pressed("cancel"):
		if Global.in_cutscene or Global.dialogue_run:
			return
		
		@warning_ignore("standalone_ternary")
		hide_panel() if visible else show_panel()
		options_menu.hide_options_screen()

func toggle_focus(enable: bool):
	for button in v_box_container.get_children():
		if button is Button:
			button.focus_mode = Control.FOCUS_ALL if enable else FOCUS_NONE

func focus_first_button():
	v_box_container.get_child(0).call_deferred("grab_focus")

func setup():
	if DataManager.load_game_data():
		load_button.disabled = false
		load_button.focus_mode = FOCUS_ALL
	else:
		load_button.disabled = true
		load_button.focus_mode = FOCUS_NONE
	
	v_box_container.get_child(0).call_deferred("grab_focus")


func show_panel():
	if Global.get_ui_win_status():
		return
	
	Global.set_ui_win_status(true)
	
	show()
	setup()
	get_tree().paused = true
	Global.freeze_input = true

func hide_panel():
	Global.set_ui_win_status(false)
	hide()
	get_tree().paused = false
	Global.freeze_input = false


func _on_button_focus_entered():
	if !Global.focus_sfx_enabled:
		return
	
	switch_sfx.play()


func _on_continue_button_pressed():
	press_sfx.play()
	hide_panel()

func _on_load_button_pressed():
	press_sfx.play()
	hide_panel()
	GameState._load_checkpoint()

func _on_new_button_pressed():
	press_sfx.play()
	hide_panel()
	GameState._on_new_game()
	NavigationManager.go_to_level("intro_cutscene")

func _on_options_button_pressed():
	press_sfx.play()
	options_menu.show_options_screen(self)

func _on_exit_button_pressed():
	press_sfx.play()
	hide_panel()
	NavigationManager.go_to_level("main_menu")
