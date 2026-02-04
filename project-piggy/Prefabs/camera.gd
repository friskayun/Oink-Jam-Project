extends Camera2D


func _physics_process(_delta):
	if get_node("../Player").motion.x > 15 or get_node("../Player").motion.y > 15 or -get_node("../Player").motion.x > -15 or -get_node("../Player").motion.y > -15:
		global_position = get_node("../Player").global_position.round()
		force_update_scroll()
