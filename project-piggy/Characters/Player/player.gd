extends CharacterBody2D
class_name Player

const SPEED = 300

@onready var anim_tree = $AnimationTree
@onready var idle_sprites = $IdleSprites
@onready var walk_sprites = $WalkSprites

var direction : Vector2 = Vector2.ZERO

func _ready():
	NavigationManager.connect("on_trigger_player_spawn", _on_spawn)
	GameState.connect("on_save_data", _save_pos)

func _physics_process(_delta):
	if Global.freeze_input or Global.in_cutscene or Global.is_player_in_vent:
		direction = Vector2.ZERO
	else:
		direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
	
	update_anim_parameters()
	
	velocity = direction * SPEED
	move_and_slide()


func _save_pos():
	GameState.set_player_global_pos(global_position)

func _on_spawn(_position: Vector2, _direction: String):
	global_position = _position
	
	match  _direction:
		"up":
			direction = Vector2.UP
		"down":
			direction = Vector2.DOWN
		"left":
			direction = Vector2.LEFT
		"right":
			direction = Vector2.RIGHT
		_:
			direction = Vector2.ZERO
	
	if direction != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = direction
		anim_tree["parameters/Walk/blend_position"] = direction

func update_anim_parameters():
	if direction == Vector2.ZERO:
		anim_tree.get("parameters/playback").travel("Idle")
		idle_sprites.visible = true
		walk_sprites.visible = false
	else:
		anim_tree.get("parameters/playback").travel("Walk")
		idle_sprites.visible = false
		walk_sprites.visible = true
	
	if direction != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = direction
		anim_tree["parameters/Walk/blend_position"] = direction
