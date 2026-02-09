extends Control


func _input(event):
	if event.is_action_pressed("interact"):
		NavigationManager.go_to_level("main_menu")
