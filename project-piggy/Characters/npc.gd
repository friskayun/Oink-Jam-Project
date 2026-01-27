extends CharacterBody2D

@export var color: Color
@export var flip: bool 
@onready var sprite = $Sprite2D

func _ready():
	sprite.modulate = color
	sprite.flip_h = flip
	jump_anim()

func jump_anim():
	var tween := create_tween()
	
	var up = sprite.position + Vector2(0, -16)
	var down = Vector2.ZERO
	tween.tween_property(sprite, "position", up, 0.1)
	tween.tween_property(sprite, "position", down, 0.1)

func look(dir: String):
	match dir:
		"left":
			sprite.frame = 0
			sprite.flip_h = true
		"right":
			sprite.frame = 0
			sprite.flip_h = false
		"up":
			sprite.frame = 8
		"down":
			sprite.frame = 4
