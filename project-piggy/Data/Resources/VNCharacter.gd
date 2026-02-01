extends Resource
class_name VisualNovelCharacter

@export var character_name: String = ""
@export var vn_sprite: Texture = null
@export var color: Color

@export var sprites: Dictionary[String, Texture2D] = {}


func get_sprite(sprite_id: String = ""):
	if sprites.size() <= 0:
		return vn_sprite
	
	if sprites.has(sprite_id):
		return sprites[sprite_id]
	else:
		return sprites.values()[0]
