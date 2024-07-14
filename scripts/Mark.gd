class_name Mark

extends Draggable

@export var n: int
var label: Label

func _ready() -> void:
	super._ready()
	label = get_node("Label")
	label.text = str(n)
