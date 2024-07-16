class_name ListItemComponent

extends Control

@onready var panel: PanelContainer = $PanelContainer
@onready var label: Label = $PanelContainer/Label
@onready var liquid: TextureRect = $PanelContainer/Liquid
@onready var tube: TextureRect = $PanelContainer/Tube

@export var empty_tube: Texture2D = load("res://sprites/empty_test_tube.svg")
@export var empty_mixer: Texture2D = load("res://sprites/mixer_template.svg")
@export var broken_mixer: Texture2D = load("res://sprites/broken_mixer.svg")
@export var mixer_liquid: Texture2D = load("res://sprites/mixer_liquid_template.svg")
@export var solid_fall: Texture2D = load("res://sprites/solid_fall_template.svg")
@export var explosion: Texture2D = load("res://sprites/explosion_template.svg")

func set_component_properties(text: String, color: Color, type: Reaction.ReactionType) -> void:
	label.text = text
	liquid.self_modulate = color
	if text == "":
		var tooltip_reaction: String = ""
		match type:
			Reaction.ReactionType.EXPLOSION:
				liquid.texture = explosion
				tube.texture = broken_mixer
				tooltip_reaction = "Explosion"
			Reaction.ReactionType.CHANGECOLOR:
				liquid.texture = mixer_liquid
				tube.texture = empty_mixer
				tooltip_reaction = "Change color"
			Reaction.ReactionType.SOLIDFALL:
				liquid.texture = solid_fall
				tube.texture = empty_mixer
				tooltip_reaction = "Precipitate"
		panel.tooltip_text = "Reaction: " + tooltip_reaction + "\nColor: #" + str(color.to_html(false))
