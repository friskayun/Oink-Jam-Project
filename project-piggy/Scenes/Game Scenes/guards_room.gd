extends Level

func _ready():
	super()
	
	$NPCs.get_node("Guard").visible = Global.is_guard_in_room
