extends CharacterBody2D
class_name Player

const WALK_SPEED = 100
const RUN_SPEED = 130

@onready var anim_tree = $AnimationTree
@onready var idle_sprites = $IdleSprites
@onready var walk_sprites = $WalkSprites
@onready var walk_sfx = $WalkSFX

signal _on_stop_moving

var direction : Vector2 = Vector2.ZERO

var is_moving_cutscene: bool = false
var destination: Vector2 = Vector2.ZERO

func _ready():
	NavigationManager.connect("on_trigger_player_spawn", _on_spawn)
	GameState.connect("on_save_data", _save_pos)

func _physics_process(_delta):
	if is_moving_cutscene:
		move_to_destination()
		return
	
	if Global.freeze_input or Global.in_cutscene or Global.is_player_in_vent:
		direction = Vector2.ZERO
	else:
		direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down").normalized()
	
	var is_running = Input.is_action_pressed("run") and direction != Vector2.ZERO
	var current_speed = RUN_SPEED if is_running else WALK_SPEED
	
	update_anim_parameters(is_running)
	
	velocity = direction * current_speed
	move_and_slide()


func _save_pos():
	GameState.set_player_global_pos(global_position)

func _on_spawn(_position: Vector2, _direction: String):
	global_position = _position
	_face_direction(_direction)

func _face_direction(_direction: String):
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


func update_anim_parameters(is_running: bool):
	if direction == Vector2.ZERO:
		anim_tree.get("parameters/playback").travel("Idle")
		idle_sprites.visible = true
		walk_sprites.visible = false
		stop_sfx()
	else:
		idle_sprites.visible = false
		walk_sprites.visible = true
		
		if is_running:
			anim_tree.get("parameters/playback").travel("Run")
			change_sfx_pitch(1.5)
		else:
			anim_tree.get("parameters/playback").travel("Walk")
			change_sfx_pitch(1)
		
		play_sfx()
	
	if direction != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = direction
		anim_tree["parameters/Walk/blend_position"] = direction
		anim_tree["parameters/Run/blend_position"] = direction

func play_sfx():
	if !walk_sfx.playing:
		walk_sfx.play()

func change_sfx_pitch(_scale: float):
	walk_sfx.pitch_scale = _scale

func stop_sfx():
	if walk_sfx.playing:
		walk_sfx.stop()

#region Storage cutscene

func _start_moving(vec: Vector2):
	is_moving_cutscene = true
	destination = vec

func _stop_moving():
	is_moving_cutscene = false
	destination = Vector2.ZERO
	_on_stop_moving.emit()

func move_to_destination():
	if global_position.distance_to(destination) >= 5:
		direction = (destination - global_position).normalized()
	else:
		direction = Vector2.ZERO
		_stop_moving()
	
	update_anim_parameters(false)
	velocity = direction * 50
	move_and_slide()

#endregion
