extends Node
class_name Data

const SCRIPT_PATH = "res://Data/Dialogue Scripts/temp_script_1.json"
const DIALOGUE_SCRIPTS = "res://Data/Dialogue Scripts/dialogue_scripts.json"


func read_script_data():
	var file = FileAccess.open(DIALOGUE_SCRIPTS, FileAccess.READ)
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
