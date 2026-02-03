extends Control
class_name Checkpoint

func _ready():
	GameState.connect("on_save_data", _save_checkpoint)
	hide()

func _save_checkpoint():
	show()
	await get_tree().create_timer(2).timeout
	hide()
