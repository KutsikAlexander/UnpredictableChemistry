extends Node2D

@export var papers: int = 1
@export var textures: Array[Texture2D]
@export var zone: Rect2
@export var paper_size: Vector2

var paper_template: PackedScene = load("res://scenes/paper.tscn")

func _ready() -> void:
    for i in range(0, papers):
        var paper: Paper = paper_template.instantiate()
        add_child(paper)
        paper.sprite2d.texture = textures[randi()%textures.size()]
        paper.original_position.x = randf_range(zone.position.x, zone.position.x+zone.size.x)
        paper.original_position.y = randf_range(zone.position.y, zone.position.y+zone.size.y)
        paper.position = paper.original_position
        paper.scale = paper_size
        paper.rotate(randf_range(0, 2*PI))