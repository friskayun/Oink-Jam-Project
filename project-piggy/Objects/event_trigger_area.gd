extends Node2D

@onready var area = $Area2D

@export var dialogue_key = "hallway_corn_factory"

func play_event():
	DialogueManager.show_dialogue_panel.emit(dialogue_key)

func _on_area_2d_body_entered(body):
	if body is Player:
		play_event()
		area.disconnect("body_entered", _on_area_2d_body_entered)
