class_name StandConstructor

extends Node2D

@export var _sections: int = 2
@export var side_part: PackedScene = load("res://scenes/stand/side_part.tscn")
@export var middle_part: PackedScene = load("res://scenes/stand/middle_part.tscn")

func construct(sections: int) -> void:
    var left_side: Node2D = side_part.instantiate()
    add_child(left_side)
    var left_side_width: float = left_side.find_child("Top").get_rect().size.x
    var middle_part_width: float
    for i in range(0, sections):
        var middle: Node2D = middle_part.instantiate()
        add_child(middle)
        middle_part_width=middle.find_child("Top").get_rect().size.x
        middle.position.x = (left_side_width/2 + (i+0.5)*middle_part_width)
    var right_side: Node2D = side_part.instantiate()
    add_child(right_side)
    right_side.position.x = left_side_width + _sections*middle_part_width
    for sprite in right_side.find_children("*", "Sprite2D", true):
        if sprite is Sprite2D:
            sprite.flip_h = true