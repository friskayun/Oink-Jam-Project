extends Node

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()

signal on_pick_up_item(item: Item)
signal _on_use_oil_item
signal on_ui_win_hide

var freeze_input: bool = false
var in_cutscene: bool = false
var dialogue_run: bool = false
var ui_win_shown: bool = false

var is_player_in_vent: bool = false
var used_oil_item = false

var curr_track: AudioStream = null

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	add_child(music_player)
	music_player.bus = "Music"

func _input(event):
	if event.is_action_pressed("screenshot"):
		take_screenshot()

func take_screenshot():
	var timestamp = Time.get_datetime_string_from_system(false, true).replace(":", "-")
	var ss = get_viewport().get_texture().get_image()
	ss.save_png("user://screenshot " + timestamp + ".png")
	print("saved ss")

func play_cutscene():
	in_cutscene = true

func end_cutscene():
	in_cutscene = false

func set_ui_win_status(value: bool):
	ui_win_shown = value
	if !ui_win_shown:
		on_ui_win_hide.emit()

func get_ui_win_status():
	return ui_win_shown

func pick_up_item(item: Item):
	on_pick_up_item.emit(item)


func player_enter_vent():
	is_player_in_vent = true

func player_exit_vent():
	is_player_in_vent = false

func use_oil_item():
	used_oil_item = true
	_on_use_oil_item.emit()


func play_track(track: AudioStream):
	if curr_track == track:
		return
	
	if track == null:
		track_fade_out()
		curr_track = null
		return
	
	curr_track = track
	music_player.stream = curr_track
	track_fade_in()

func track_fade_in():
	music_player.volume_db = -60
	music_player.play()
	create_tween().tween_property(music_player, "volume_db", -10, 1.5)

func track_fade_out():
	var tween = create_tween()
	tween.tween_property(music_player, "volume_db", -60, 1)
	await tween.finished
	music_player.stop()
