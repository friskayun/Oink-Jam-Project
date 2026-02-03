extends Control

const intro_bus_scene = "intro_bus_scene"
const hallway_corn_factory = "hallway_corn_factory"


func _on_new_button_pressed():
	GameState._on_new_game()
	NavigationManager.go_to_level("hallway_corn_factory")


func _on_load_button_pressed():
	GameState._load_checkpoint()


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_credits_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()
