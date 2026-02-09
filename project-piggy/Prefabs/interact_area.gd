extends Area2D
class_name InteractArea

@export var action_name: String = ""

var interact: Callable = func(): 
	pass

var use_item: Callable = func():
	return false

func _on_body_entered(_body):
	InteractionManager.register_area(self)
	pass


func _on_body_exited(_body):
	InteractionManager.unregister_area(self)
	pass # Replace with function body.
