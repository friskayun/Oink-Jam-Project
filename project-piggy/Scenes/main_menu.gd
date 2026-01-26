extends Control

const GAME_SCENE = "uid://3yn11wshixle"
const TEST_GAME_SCENE = "uid://cldtus0sc2416"


func _on_new_button_pressed():
	get_tree().change_scene_to_file(TEST_GAME_SCENE)


func _on_load_button_pressed():
	pass # Replace with function body.


func _on_options_button_pressed():
	pass # Replace with function body.


func _on_credits_button_pressed():
	pass # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit()
