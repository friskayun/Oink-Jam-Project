extends CharacterBody2D
class_name Poppy

@onready var anim_tree = $AnimationTree
@onready var idle_sprites = $IdleSprites
@onready var walk_sprites = $WalkSprites

const SPEED = 100

@export var player: Player 

var in_cage = true
var direction: Vector2 = Vector2.ZERO

func _ready():
	GameState.connect("start_final_chase", _follow_penny)
	
	direction = Vector2.ZERO
	update_anim_parameters()

func _physics_process(_delta):
	if in_cage:
		return
	
	update_anim_parameters()
	_follow_penny()

func _follow_penny():
	in_cage = false
	
	if global_position.distance_to(player.global_position) > 16:
		direction = (player.global_position - global_position).normalized()
	else:
		direction = Vector2.ZERO
	
	velocity = direction * SPEED
	move_and_slide()

func freeze():
	in_cage = true
	direction = Vector2.ZERO
	update_anim_parameters()

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
