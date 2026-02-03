extends CharacterBody2D
class_name Player

const SPEED = 900


func _ready():
	NavigationManager.connect("on_trigger_player_spawn", _on_spawn)
	GameState.connect("on_save_data", _save_pos)

func _process(_delta):
	if Global.freeze_input or Global.in_cutscene or Global.is_player_in_vent:
		velocity = Vector2.ZERO
		return
	
	var dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	velocity = dir * SPEED
	move_and_slide()

@warning_ignore("unused_parameter")
func _on_spawn(_position: Vector2, direction: String):
	global_position = _position
	#anim sprite to dir

func _save_pos():
	GameState.set_player_global_pos(global_position)
