class_name List

extends Control

@onready var button:Button = $Button
@onready var listPanel: Control = $PanelContainer
@onready var list:Control = $PanelContainer/MarginContainer/ScrollContainer/VBoxContainer
var list_item_prefab:PackedScene = load("res://scenes/list_item.tscn")

func set_reactions(reactions: Array[Reaction]) -> void:
	for reaction in reactions:
		var list_item: ListItem = list_item_prefab.instantiate()
		list.add_child(list_item)
		list_item.set_reaction(reaction)

func hide_list() -> void:
	if listPanel.visible:
		button.text = "Show list"
		listPanel.visible = false
	else:
		button.text = "Hide"
		listPanel.visible = true
