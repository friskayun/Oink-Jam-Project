extends CanvasLayer

@onready var anim_player = $AnimationPlayer
@onready var inspect_sfx = $InspectSFX
@onready var texture_rect = $Visual/MarginContainer/TextureRect

var can_close: bool = false

func _ready():
	visible = false
	can_close = false

func _input(event):
	if (event.is_action_pressed("interact") or event.is_action_pressed("cancel")) and can_close:
		hide_item_inspect()

func show_item_inspect(item: Item = null):
	if Global.get_ui_win_status():
		return
	
	Global.set_ui_win_status(true)
	
	if item != null:
		texture_rect.texture = item.item_texture
	
	visible = true
	get_tree().paused = true
	inspect_sfx.play()
	anim_player.play("show_item")
	await anim_player.animation_finished
	can_close = true

func hide_item_inspect():
	can_close = false
	anim_player.play("hide_item")
	await anim_player.animation_finished
	visible = false
	get_tree().paused = false
	Global.set_ui_win_status(false)
