extends Camera2D

func _physics_process(_delta):
	global_position = global_position.round()
	#force_update_scroll()
