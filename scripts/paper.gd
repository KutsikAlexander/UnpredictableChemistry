class_name Paper

extends Draggable

@onready var sprite2d: Sprite2D = $Sprite2D

func _ready() -> void:
    original_z_index = -10
    super._ready()
    drop.connect(on_drop)
    

func on_drop() -> void:
    original_position = position
