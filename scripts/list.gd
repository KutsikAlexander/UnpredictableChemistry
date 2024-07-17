class_name List

extends Control

@onready var list:Control = $ScrollContainer/VBoxContainer
var list_item_template:PackedScene = load("res://scenes/list_item.tscn")

func set_reactions(reactions: Array[Reaction]) -> void:
	for reaction in reactions:
		var list_item: ListItem = list_item_template.instantiate()
		list.add_child(list_item)
		list_item.set_reaction(reaction)
