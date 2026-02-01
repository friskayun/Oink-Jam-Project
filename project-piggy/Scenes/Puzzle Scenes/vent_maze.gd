extends Node2D

const VENT_TILE = preload("uid://ciexudc5eq80w")

const wall_color: Color = Color.BLACK
const path_color: Color = Color.BLANCHED_ALMOND
const vent_color: Color = Color.PALE_TURQUOISE

const WALL = 0
const PATH = 1
const VENT_STORAGE = 2
const VENT_SECURITY = 3
const VENT_LOCKER = 4
const VENT_GUARD = 5

const TILE_GAP = 36                #32px  tile size + 4px gap
const OFFSET = 18

var curr_player_col: int = 5
var curr_player_row: int = 7

var on_vent: bool = false

var vent_rooms: Dictionary = {
	VENT_STORAGE: {"scene_id": "storage_scene", "destination_id": "V_Up", "x": 5, "y": 8},
	VENT_SECURITY: {"scene_id": "security_room", "destination_id": "V_Up", "x": 0, "y": 6},
	VENT_LOCKER: {"scene_id": "lockers_room", "destination_id": "V_Up", "x": 10, "y": 3},
	VENT_GUARD: {"scene_id": "guards_room", "destination_id": "V_Up", "x": 2, "y": 0}
}

var grid = [
	[0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0],
	[1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
	[1, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0],
	[1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 4],
	[0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 1],
	[0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1],
	[3, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0],
	[0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0],
	[0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0],
]

func _ready():
	if NavigationManager.spawn_door_tag != null:
		switch_to_vent(int(NavigationManager.spawn_door_tag))
	
	clear_tiles()
	draw_vent_maze()

func _input(event):
	if event.is_action_pressed("interact") and on_vent:
		switch_to_room()
	
	if event.is_action_pressed("walk_down"):
		move_player(1, 0)
	elif event.is_action_pressed("walk_up"):
		move_player(-1, 0)
	elif event.is_action_pressed("walk_left"):
		move_player(0, -1)
	elif event.is_action_pressed("walk_right"):
		move_player(0, 1)

func draw_vent_maze():
	for row in grid.size():
		for col in grid[row].size():
			var obj = VENT_TILE.instantiate() as Sprite2D
			obj.global_position = Vector2(col * TILE_GAP + OFFSET, row * TILE_GAP + OFFSET)
			match grid[row][col]:
				WALL:
					obj.modulate = wall_color
				PATH:
					obj.modulate = path_color
				_:
					obj.modulate = vent_color
			%tiles.add_child(obj)

func clear_tiles():
	for tile in %tiles.get_children():
		tile.queue_free()


func spawn_player():
	%PlayerSprite.global_position = Vector2(curr_player_col * TILE_GAP + OFFSET, curr_player_row * TILE_GAP + OFFSET)

func move_player(row: int, col: int):
	var next_row = curr_player_row + row
	var next_col = curr_player_col + col
	
	if next_row >= grid.size() or next_row < 0:
		return
	if next_col >= grid[next_row].size() or next_col < 0:
		return
	
	if grid[next_row][next_col] == WALL:
		return
	
	on_vent = true if grid[next_row][next_col] != PATH else false
	
	curr_player_row = next_row
	curr_player_col = next_col
	
	%PlayerSprite.global_position = Vector2(curr_player_col * TILE_GAP + OFFSET, curr_player_row * TILE_GAP + OFFSET)


func switch_to_vent(index: int):
	Global.player_enter_vent()
	curr_player_col = vent_rooms[index]["x"]
	curr_player_row = vent_rooms[index]["y"]
	
	if grid[curr_player_row][curr_player_col] == index:
		on_vent = true
	else:
		print("error: wrong coordinats")
	
	spawn_player()

func switch_to_room():
	var index = grid[curr_player_row][curr_player_col]
	var scene_id = vent_rooms[index]["scene_id"]
	var destination_id = vent_rooms[index]["destination_id"]
	NavigationManager.go_to_level(scene_id, destination_id)
