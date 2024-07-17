extends Node2D

@export var papers: int = 1
@export var textures: Array[Texture2D]
@export var zone: Rect2
@export var paper_size: Vector2

func _ready() -> void:
    for i in range(0, papers):
        var sprite2d = Sprite2D.new()
        sprite2d.texture = textures[randi()%textures.size()]
        add_child(sprite2d)
        sprite2d.position.x = randf_range(zone.position.x, zone.position.x+zone.size.x)
        sprite2d.position.y = randf_range(zone.position.y, zone.position.y+zone.size.y)
        sprite2d.scale = paper_size
        sprite2d.rotate(randf_range(0, 2*PI))
        sprite2d.z_index = -1