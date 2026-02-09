extends Control

@onready var master_audio = $Panel/VBoxContainer/Volume/MasterAudio
@onready var music_audio = $Panel/VBoxContainer/Volume2/MusicAudio
@onready var sfx_audio = $Panel/VBoxContainer/Volume3/SFXAudio
@onready var switch_sfx = $SwitchSFX
@onready var press_sfx = $PressSFX

var caller: Control = null
var audio_bus_id

func _ready():
	hide()
	master_audio.value = Global.master_vol
	music_audio.value = Global.music_vol
	sfx_audio.value = Global.sfx_vol


func show_options_screen(_caller: Control):
	show()
	
	Global.disable_focus_sfx()
	master_audio.call_deferred("grab_focus")
	await get_tree().process_frame
	Global.enable_focus_sfx()
	
	caller = _caller
	caller.toggle_focus(false)

func hide_options_screen():
	hide()
	
	if !caller:
		return
	
	caller.toggle_focus(true)
	
	Global.disable_focus_sfx()
	caller.focus_first_button()
	await get_tree().process_frame
	Global.enable_focus_sfx()
	
	caller = null

func _on_master_audio_value_changed(value):
	Global.master_vol = value
	var db = linear_to_db(value)
	audio_bus_id = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(audio_bus_id, db)
	press_sfx.play()

func _on_music_audio_value_changed(value):
	Global.music_vol = value
	var db = linear_to_db(value)
	audio_bus_id = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(audio_bus_id, db)
	press_sfx.play()

func _on_sfx_audio_value_changed(value):
	Global.sfx_vol = value
	var db = linear_to_db(value)
	audio_bus_id = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(audio_bus_id, db)
	press_sfx.play()

func _on_fullscreen_button_toggled(toggled_on):
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	press_sfx.play()

func _on_button_pressed():
	hide_options_screen()


func _on_focus_entered():
	if !Global.focus_sfx_enabled:
		return
	
	switch_sfx.play()
