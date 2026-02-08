extends ObjectInteract

const SLEEPING_PILLS = preload("uid://bqfep7s4a6du5")

@export var locker_num: String = "001"
@export var flip: bool = false
@onready var collision_shape_2d = $"Interact Area/CollisionShape2D"

func _ready():
	super()
	if flip:
		collision_shape_2d.position.y -= 12

func _on_interact():
	DialogueManager.play_dialogue("locker_locked")
	await DialogueManager.dialogue_ended

func use_item_action():
	DialogueManager.play_dialogue("guard_locker_unlock_idle")
	await DialogueManager.dialogue_ended
	
	if !GameState.is_item_taken(SLEEPING_PILLS.item_id):
		DialogueManager.play_dialogue("guard_locker_unlock_item")
		await DialogueManager.dialogue_ended
		DialogueManager.play_choice("pills_choice", _on_choice)

func _on_choice(index: int):
	match index:
		0:
			if GameState.curr_state <= GameState.STATE.FIND_LOCKER:
				GameState.curr_state = GameState.STATE.PUT_TO_SLEEP
			GameState.took_item(SLEEPING_PILLS.item_id)
			Global.pick_up_item(SLEEPING_PILLS)
		1: 
			pass
