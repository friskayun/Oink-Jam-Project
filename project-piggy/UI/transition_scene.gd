extends CanvasLayer

@onready var anim_player = $AnimationPlayer

signal on_transition_finished

func _ready():
	visible = false
	anim_player.connect("animation_finished", _on_animation_finished)

func play_transition():
	visible = true
	Global.freeze_input = true
	anim_player.play("fade_out")

func _on_animation_finished(anim_name):
	if anim_name == "fade_out":
		on_transition_finished.emit()
		anim_player.play("fade_in")
	elif anim_name == "fade_in":
		visible = false
		Global.freeze_input = false

func play_fade_in_transition():
	visible = true
	anim_player.play("fade_in")
	await anim_player.animation_finished
	on_transition_finished.emit()
	visible = false
