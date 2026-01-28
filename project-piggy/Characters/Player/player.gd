extends CharacterBody2D
class_name Player

const SPEED = 300


func _ready():
	NavigationManager.connect("on_trigger_player_spawn", _on_spawn)

func _process(_delta):
	if Global.freeze_input:
		velocity = Vector2.ZERO
		return
	
	var dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	velocity = dir * SPEED
	move_and_slide()

@warning_ignore("unused_parameter")
func _on_spawn(_position: Vector2, direction: String):
	print(global_position)
	global_position = _position
	print(global_position)
	#anim sprite to dir
