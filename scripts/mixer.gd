class_name Mixer

extends Draggable

var ingredients: Array[int]
var reactions: Array[Reaction]
var clicks: int = 0
var liquid: Sprite2D
var last_interactable_object: TestTube = null

func _ready() -> void:
	super._ready()
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	liquid = get_node("Sprite2D")
	

func _on_area_entered(other: Area2D) -> void:
	if other is TestTube:
		last_interactable_object = other
		last_interactable_object.drop.connect(_on_drop)
	if other.name == "Flush":
		flush()
		dragged = false

func _on_area_exited(other: Area2D) -> void:
	if other == last_interactable_object:
		last_interactable_object.drop.disconnect(_on_drop)
		last_interactable_object = null

func _on_drop() -> void:
	if last_interactable_object != null:
		mix(last_interactable_object.n, last_interactable_object._color)
		dragged = false

func mix(number: int, color: Color) -> void:
	print(number)
	if clicks == 0:
		liquid.self_modulate = color
		ingredients.push_back(number)
		clicks+=1
	elif clicks == 1:
		if(ingredients[0] != number):
			ingredients.push_back(number)
			ingredients.sort()
			clicks+=1
			print("Reaction")
			for r in reactions:
				if r.ingredients == ingredients:
					show_reaction(r)
					r.print()
					break
		else:
			print("Already there")
	else:
		print("Full")

func check_reaction() -> void:
	pass

func flush() -> void:
	liquid.self_modulate = Color.WHITE
	ingredients.clear()
	clicks = 0
	print("Mixer is clear")

func show_reaction(reaction: Reaction) -> void:
	liquid.self_modulate = reaction.color