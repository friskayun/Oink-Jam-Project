extends Node2D

@export var destination_level_tag: String = ""
## ending_screen
var ending_id_1 = "good_ending_explosion"
var ending_id_2 = "good_ending_default"

func _on_area_body_entered(body):
	if body is Player:
		if GameState.dynamite_lighted:
			NavigationManager.go_to_level(destination_level_tag, ending_id_1)
		else:
			NavigationManager.go_to_level(destination_level_tag, ending_id_2)
