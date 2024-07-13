class_name TestTube

extends Sprite2D

@export_color_no_alpha var _color: Color

signal use_tube(color: Color)

func _ready() -> void:
    self_modulate = _color

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
        if get_rect().has_point(to_local(event.position)):
            use_tube.emit(_color)
