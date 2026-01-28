extends Area2D
class_name Door

@export var destination_level_tag: String = ""             # change to which level
@export var destination_door_tag: String = ""          # door in next level
@export var direction_spawn: String = ""               # Player spawn sprite direction

@onready var spawn = $Spawn


func _on_body_entered(body):
	if body is Player:
		NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
