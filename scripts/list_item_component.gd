class_name ListItemComponent

extends Control

@onready var label: Label = $PanelContainer/Label
@onready var image: TextureRect = $PanelContainer/TextureRect

func set_component_properties(text: String, color: Color) -> void:
    label.text = text
    image.self_modulate = color