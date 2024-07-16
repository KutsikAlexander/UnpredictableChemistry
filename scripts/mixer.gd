class_name Mixer

extends Acceptor

var ingredients: Array[int]
var reactions: Array[Reaction]
var clicks: int = 0
@onready var liquid: Sprite2D = $Liquid
@onready var solid: Sprite2D = $Solid
@onready var tube: Sprite2D = $Tube

@onready var reaction_particle: CPUParticles2D = $Reaction
@onready var explosion_particle = $Explosion

@export var empty_mixer: Texture2D = load("res://sprites/mixer_template.svg")
@export var broken_mixer: Texture2D = load("res://sprites/broken_mixer.svg")
@export var mixer_liquid: Texture2D = load("res://sprites/mixer_liquid_template.svg")
@export var solid_fall: Texture2D = load("res://sprites/solid_fall_template.svg")

func _ready() -> void:
	super._ready()
	flush()

func _on_drop() -> void:
	if draggable is TestTube:
		mix(draggable.n, draggable.color)

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
	liquid.self_modulate = Color.TRANSPARENT
	solid.self_modulate = Color.TRANSPARENT
	tube.texture = empty_mixer
	ingredients.clear()
	clicks = 0
	print("Mixer is clear")

func show_reaction(reaction: Reaction) -> void:
	match reaction.type:
		Reaction.ReactionType.EXPLOSION:
			liquid.self_modulate = Color.TRANSPARENT
			tube.texture = broken_mixer
			explosion_particle.color = reaction.color
			explosion_particle.emitting = true
		Reaction.ReactionType.CHANGECOLOR:
			liquid.self_modulate = reaction.color
			reaction_particle.color = reaction.color
			reaction_particle.emitting = true
		Reaction.ReactionType.SOLIDFALL:
			solid.self_modulate = reaction.color
			reaction_particle.color = reaction.color
			reaction_particle.emitting = true

