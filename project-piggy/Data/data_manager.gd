extends Node
class_name Data

const GAME_DATA_PATH = "user://GameData.json"

const ITEMS_PATH = "res://Data/Resources/Items/"

const SCRIPT_PATH = "res://Data/Dialogue Scripts/temp_script_1.json"
const DIALOGUE_SCRIPTS = "res://Data/Dialogue Scripts/dialogue_scripts.json"
const CHOICES_SCRIPT = "res://Data/Dialogue Scripts/choices_script.json"

var item_resources: Dictionary = {
	"access_card_guard": preload("uid://b82xkabpi757b"),
	"emails": preload("uid://dchh5pek47b17"),
	"hair_pin_hallway": preload("uid://cquiyclkfhpy8"),
	"locker_key_guard": preload("uid://dx8f1y3dpjba2"),
	"lighter_security": preload("uid://bctbnurjsvah2"),
	"oil_bottle_guard": preload("uid://naso8kxch7yx"),
	"screwdriver_storage": preload("uid://bqbp21mulaqaq"),
	"sleeping_pills_lockers": preload("uid://bqfep7s4a6du5"),
	"vent_map": preload("uid://c4k8s22e033h6")
}


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

func get_item_resource_by_item_id(id: String):
	return item_resources.get(id)

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
