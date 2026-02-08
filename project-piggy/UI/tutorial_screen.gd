extends CanvasLayer

@onready var anim_player = $AnimationPlayer

func _ready():
	hide()

func _input(event):
	if (event.is_action_pressed("cancel") or event.is_action_pressed("interact")) and visible:
		hide_screen()

func show_screen():
	show()
	anim_player.play("fade_in")
	Global.set_ui_win_status(true)
	Global.freeze_input = true


func hide_screen():
	anim_player.play("fade_out")
	await anim_player.animation_finished
	hide()
	Global.freeze_input = false
	Global.set_ui_win_status(false)
