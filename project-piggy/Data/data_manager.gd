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
