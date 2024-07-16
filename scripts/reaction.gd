class_name Reaction

enum ReactionType {CHANGECOLOR, SOLIDFALL, EXPLOSION}

var ingredients: Array[int]
var id: int = 0
var type: ReactionType
var color: Color

func _init(_ingredients: Array[int], _id: int, _color: Color) -> void:
	_ingredients.sort();
	ingredients = _ingredients
	id = _id
	type = ReactionType.values()[_id%ReactionType.size()]
	color = _color

func print() -> void:
	print("first:")
	print(ingredients[0])
	print("second:")
	print(ingredients[1])
	print("id:")
	print(id)
	print("type")
	print(type)
