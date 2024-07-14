class_name TestTube

extends Draggable

@export_color_no_alpha var _color: Color
@export var n: int
var label: Label
var label_pivot: Node2D
var mark: Mark = null

func _ready() -> void:
	super._ready()
	get_node("Sprite2D").self_modulate = _color
	label = get_node("Label")
	label.text = "?"
	label_pivot = get_node("LabelPivot")
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(other: Area2D) -> void:
	if other is Mark:
		mark = other
		mark.drop.connect(_on_mark_drop)

func _on_area_exited(other: Area2D) -> void:
	if other == mark:
		mark.drop.disconnect(_on_mark_drop)
		mark = null

func _on_mark_drop() -> void:
	if mark != null:
		label.text = str(mark.label.text)
		dragged = false