extends Sprite2D

func _ready() -> void:
    for testTube in get_parent().find_children("TestTube*", "TestTube", false):
        if testTube is TestTube:
            testTube.use_tube.connect(mix)

func mix(color: Color) -> void:
    self_modulate = (self_modulate + color)/2