extends CharacterBody2D
class_name MeatWorker

@onready var anim_player = $AnimationPlayer
@onready var anim_tree = $AnimationTree
@onready var idle_sprites = $IdleSprites
@onready var walk_sprites = $WalkSprites
@onready var sleep_sprite = $SleepSprite
@onready var timer = $Timer
@onready var walk_sfx = $walk_sfx

const CHASE_SPEED = 150
const SLOW_SPEED = 75

@export var player: Player 
@export var is_guard = false

signal _on_stop_moving

var speed = 350
var is_chasing = false
var direction: Vector2 = Vector2.ZERO

var is_moving_cutscene = false
var destination: Vector2 = Vector2.ZERO

func _ready():
	if is_guard:
		guard_up()
	timer.wait_time = 3
	timer.autostart = true
	speed = CHASE_SPEED
	direction = Vector2.ZERO
	update_anim_parameters()

func _physics_process(_delta):
	if Global.freeze_input and !is_moving_cutscene and !is_guard:
		direction = Vector2.ZERO
		update_anim_parameters()
		return
	
	if is_moving_cutscene:
		move_anim_manual()
	
	if !is_chasing:
		return
	
	update_anim_parameters()
	_follow_player()

func start_chase():
	is_chasing = true

func stop_chase():
	is_chasing = false

func _follow_player():
	if global_position.distance_to(player.global_position) >= 8:
		direction = (player.global_position - global_position).normalized()
	else:
		direction = Vector2.ZERO
	
	velocity = direction * speed
	move_and_slide()

func update_anim_parameters():
	if direction == Vector2.ZERO:
		anim_tree.get("parameters/playback").travel("Idle")
		idle_sprites.visible = true
		walk_sprites.visible = false
		sleep_sprite.visible = false
		stop_sfx()
	else:
		anim_tree.get("parameters/playback").travel("Walk")
		idle_sprites.visible = false
		walk_sprites.visible = true
		sleep_sprite.visible = false
		play_sfx()
	
	if direction != Vector2.ZERO:
		anim_tree["parameters/Idle/blend_position"] = direction
		anim_tree["parameters/Walk/blend_position"] = direction


func play_sfx():
	if !walk_sfx.playing:
		walk_sfx.play()

func stop_sfx():
	if walk_sfx.playing:
		walk_sfx.stop()


func _on_area_2d_body_entered(body):
	if (body is Player or body is Poppy) and !is_guard:
		if body is Poppy:
			body.freeze()
		
		stop_chase()
		NavigationManager.go_to_level("ending_screen", "5")


#region Storage cutscene

func move_anim_manual():
	if global_position.distance_to(destination) >= 32:
		direction = (destination - global_position).normalized()
	else:
		_stop_moving()
	
	update_anim_parameters()
	velocity = direction * SLOW_SPEED
	move_and_slide()

func _start_moving(x: int):
	is_moving_cutscene = true
	destination = Vector2(x, global_position.y)

func _stop_moving():
	is_moving_cutscene = false
	direction = Vector2.ZERO
	destination = Vector2.ZERO
	_on_stop_moving.emit()

#endregion

#region Last Chase

func _slow_down():
	speed = SLOW_SPEED
	timer.start()
	
func _on_timer_timeout():
	speed = CHASE_SPEED

#endregion

#region Guard Room

func guard_up():
	direction = Vector2.DOWN
	update_anim_parameters()
	direction = Vector2.ZERO

func guard_fall_asleep_anim():
	#await get_tree().create_timer(2).timeout
	anim_tree.get("parameters/playback").travel("fall_asleep")
	idle_sprites.visible = false
	walk_sprites.visible = false
	sleep_sprite.visible = true

func guard_sleep_anim():
	anim_tree.get("parameters/playback").travel("sleep")
	idle_sprites.visible = false
	walk_sprites.visible = false
	sleep_sprite.visible = true

#endregion
