extends CanvasLayer

@onready var anim_player = $AnimationPlayer

var can_close: bool = false

func _ready():
	visible = false
	can_close = false

func _input(event):
	if event.is_action_pressed("interact") and can_close:
		hide_item_inspect()

func show_item_inspect(item: Item = null):
	if Global.get_ui_win_status():
		return
	
	Global.set_ui_win_status(true)
	
	if item != null:
		$Visual/TextureRect.texture = item.item_texture
	
	visible = true
	get_tree().paused = true
	anim_player.play("show_item")
	await anim_player.animation_finished
	can_close = true

func hide_item_inspect():
	Global.set_ui_win_status(false)
	can_close = false
	anim_player.play("hide_item")
	await anim_player.animation_finished
	visible = false
	get_tree().paused = false
