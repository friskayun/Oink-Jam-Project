extends Camera2D

@onready var player := get_node("../Player")

func _physics_process(_delta):
	global_position = player.global_position.round()
	force_update_scroll()
