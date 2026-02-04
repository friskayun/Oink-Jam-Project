extends CharacterBody2D

@onready var anim_tree = $AnimationTree
@onready var idle_sprites = $IdleSprites
@onready var walk_sprites = $WalkSprites

@export var y_destination: int = 240
@export var x_destination: int = 850

const SPEED = 400

var in_cage = true
var direction: Vector2 = Vector2.ZERO

func _ready():
	GameState.connect("start_final_chase", run_away_guard)
	
	direction = Vector2.ZERO
	update_anim_parameters()

func _process(_delta):
	if in_cage:
		return
	
	if global_position.distance_to(Vector2(x_destination, global_position.y)) <= 10:
		queue_free()
	
	update_anim_parameters()
	run_away_guard()

func run_away_guard():
	in_cage = false
	
	if global_position.distance_to(Vector2(global_position.x, y_destination)) >= 10:
		direction = (Vector2(global_position.x, y_destination) - global_position).normalized()
	else:
		direction = (Vector2(x_destination, global_position.y) - global_position).normalized()
	
	velocity = direction * SPEED
	move_and_slide()

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
