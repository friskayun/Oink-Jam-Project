extends CharacterBody2D

const IDLE_NPC_01 = preload("uid://g7ogh6qiwjv7")
const IDLE_NPC_02 = preload("uid://b6ubh3apx1qxv")
const IDLE_NPC_03 = preload("uid://cytxmp5uybmc1")
const WALKING_NPC_01 = preload("uid://b37ehmu361g08")
const WALKING_NPC_02 = preload("uid://de2syqq0l55xy")
const WALKING_NPC_03 = preload("uid://b4x0lqst7guqk")


@onready var anim_tree = $AnimationTree
@onready var idle_sprites = $IdleSprites
@onready var walk_sprites = $WalkSprites

@export var y_destination: int = 110
@export var x_destination: int = 258
@export var skin: int = 1

const SPEED = 100

var in_cage = true
var direction: Vector2 = Vector2.ZERO

var skins: Dictionary = {
	1: {"idle": IDLE_NPC_01, "walk": WALKING_NPC_01},
	2: {"idle": IDLE_NPC_02, "walk": WALKING_NPC_02},
	3: {"idle": IDLE_NPC_03, "walk": WALKING_NPC_03}
}

func _ready():
	GameState.connect("start_final_chase", run_away_guard)
	
	set_skin()
	direction = Vector2.ZERO
	update_anim_parameters()

func _physics_process(_delta):
	if in_cage:
		return
	
	if global_position.distance_to(Vector2(x_destination, global_position.y)) <= 4:
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

func set_skin():
	if !skins.has(skin):
		skin = 1
	
	idle_sprites.texture = skins[skin]["idle"]
	walk_sprites.texture = skins[skin]["walk"]
