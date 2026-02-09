extends Node2D

@export var destination_level_tag: String = ""
## ending_screen
@export var ending_id_1 = "0"
@export var ending_id_2 = "0"

func _on_area_body_entered(body):
	if body is Player:
		Global.play_track(null)
		if GameState.dynamite_lighted:
			NavigationManager.go_to_level(destination_level_tag, ending_id_1)
		else:
			NavigationManager.go_to_level(destination_level_tag, ending_id_2)
