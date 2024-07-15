class_name ListItemComponent

extends Control

@onready var label: Label = $PanelContainer/Label
@onready var liquid: TextureRect = $PanelContainer/Liquid

func set_component_properties(text: String, color: Color) -> void:
    label.text = text
    liquid.self_modulate = color