class_name Mixer

extends Acceptor

var ingredients: Array[int]
var reactions: Array[Reaction]
var clicks: int = 0

# Sprites
@onready var liquid: Sprite2D = $Liquid
@onready var solid: Sprite2D = $Solid
@onready var tube: Sprite2D = $Tube

# Particles
@onready var reaction_particle: CPUParticles2D = $Reaction
@onready var explosion_particle = $Explosion

# Textures
@export var empty_mixer: Texture2D = load("res://sprites/mixer_template.svg")
@export var broken_mixer: Texture2D = load("res://sprites/broken_mixer.svg")
@export var mixer_liquid: Texture2D = load("res://sprites/mixer_liquid_template.svg")
@export var solid_fall: Texture2D = load("res://sprites/solid_fall_template.svg")

# Sounds
@onready var audio_stream: AudioStreamPlayer = $AudioStreamPlayer
@export var water_sounds: Array[AudioStream]
@export var reaction_sounds: Array[AudioStream]
@export var explosion_sounds: Array[AudioStream]

func _ready() -> void:
	super._ready()
	flush(false)

func _on_drop() -> void:
	if draggable is TestTube:
		mix(draggable.n, draggable.color)

func mix(number: int, color: Color) -> void:
	print(number)
	if clicks == 0:
		liquid.self_modulate = color
		audio_stream.stream = water_sounds[randi()%water_sounds.size()]
		audio_stream.playing = true
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

func flush(with_sound: bool = true) -> void:
	liquid.self_modulate = Color.TRANSPARENT
	solid.self_modulate = Color.TRANSPARENT
	tube.texture = empty_mixer
	audio_stream.stream = water_sounds[randi()%water_sounds.size()]
	if with_sound:
		audio_stream.playing = true
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
			audio_stream.stream = explosion_sounds[randi()%explosion_sounds.size()]
		Reaction.ReactionType.CHANGECOLOR:
			liquid.self_modulate = reaction.color
			reaction_particle.color = reaction.color
			reaction_particle.emitting = true
			audio_stream.stream = reaction_sounds[randi()%reaction_sounds.size()]
		Reaction.ReactionType.SOLIDFALL:
			solid.self_modulate = reaction.color
			reaction_particle.color = reaction.color
			reaction_particle.emitting = true
			audio_stream.stream = reaction_sounds[randi()%reaction_sounds.size()]
	audio_stream.playing = true

