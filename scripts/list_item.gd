class_name ListItem

extends Control

@onready var ingredient1:ListItemComponent = $PanelContainer/HBoxContainer/ListItemComponent1
@onready var ingredient2:ListItemComponent = $PanelContainer/HBoxContainer/ListItemComponent2
@onready var result:ListItemComponent = $PanelContainer/HBoxContainer/ListItemComponent3

func set_reaction(reaction: Reaction) -> void:
	ingredient1.set_component_properties(str(reaction.ingredients[0]+1), Color.WHITE)
	ingredient2.set_component_properties(str(reaction.ingredients[1]+1), Color.WHITE)
	result.set_component_properties("", reaction.color)
