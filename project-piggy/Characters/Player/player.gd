extends CharacterBody2D
class_name Player

const SPEED = 300

func _process(_delta):
	var dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	velocity = dir * SPEED
	move_and_slide()
