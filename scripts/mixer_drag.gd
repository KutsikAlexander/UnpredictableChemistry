class_name MixerDrag

extends Draggable

var ingredients: Array[int]
var reactions: Array[Reaction]
var clicks: int = 0
@onready var liquid: Sprite2D = $Liquid

func _ready() -> void:
	super._ready()

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