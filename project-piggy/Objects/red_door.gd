extends Node2D

@export var destination_level_tag: String = ""             # change to which level
@export var destination_door_tag: String = ""          # door in next level
@export var direction_spawn: String = ""
   
@onready var spawn = $Spawn

@onready var interact_area: InteractArea = $"Interact Area"

func _ready():
	interact_area.interact = Callable(self, "_on_interact")

func _on_interact():
	NavigationManager.go_to_level(destination_level_tag, destination_door_tag)
