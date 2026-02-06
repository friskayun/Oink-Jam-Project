extends Node
class_name Data

const GAME_DATA_PATH = "user://GameData.json"

const ITEMS_PATH = "res://Data/Resources/Items/"

const SCRIPT_PATH = "res://Data/Dialogue Scripts/temp_script_1.json"
const DIALOGUE_SCRIPTS = "res://Data/Dialogue Scripts/dialogue_scripts.json"
const CHOICES_SCRIPT = "res://Data/Dialogue Scripts/choices_script.json"

var item_resources: Array[Item] = []

func _ready():
	read_item_resources()

func read_script_data(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	var file_content = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(file_content)
	return data

func fetch_resources(folder_path: String) -> Array:
	var array = []
	
	var dir = DirAccess.open(folder_path)
	if dir == null:
		print("[Error] Could't open directory.")
		return array
	
	for file in dir.get_files():
		if file.ends_with(".tres"):
			var res = load(folder_path + file)
			if res:
				array.append(res)
	
	return array

func read_item_resources():
	var dir = DirAccess.open(ITEMS_PATH)
	if dir == null:
		return
	
	for file in dir.get_files():
		if file.ends_with(".tres"):
			var res = load(ITEMS_PATH + file)
			if res:
				item_resources.append(res)

func get_item_resource_by_item_id(id: String):
	for item in item_resources:
		if item.item_id == id:
			return item
	return null

func save_game_data(data: Dictionary):
	var file = FileAccess.open(GAME_DATA_PATH, FileAccess.WRITE)
	file.store_var(data.duplicate())
	file.close()

func load_game_data():
	if FileAccess.file_exists(GAME_DATA_PATH):
		var file = FileAccess.open(GAME_DATA_PATH, FileAccess.READ)
		var load_data = file.get_var().duplicate()
		file.close()
		
		return load_data
	return null

func delete_save_data():
	if FileAccess.file_exists(GAME_DATA_PATH):
		DirAccess.remove_absolute(GAME_DATA_PATH)
