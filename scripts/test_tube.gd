class_name TestTube

extends Draggable

@export_color_no_alpha var _color: Color
@export var n: int
var m: int = 0
var label: Label
var label_pivot: Node2D
var mark: Mark = null
var buttons: Array[Button]

signal value_changed

func _ready() -> void:
	super._ready()
	get_node("Sprite2D").self_modulate = _color
	label = get_node("Label")
	label.text = "?"
	label_pivot = get_node("LabelPivot")
	for button in find_children("*Button*", "Button"):
		if button is Button:
			buttons.append(button)
	hide_buttons()
	picked_up.connect(hide_buttons)

func set_properties(_n: int, color: Color) -> void:
	n = _n
	_color = color

func increase_value() -> void:
	m+=1
	value_changed.emit()
	label.text = str(m)

func decrease_value() -> void:
	if m > 0:
		m-=1
		value_changed.emit()
		label.text = str(m)
	if m == 0:
		label.text = "?"

func show_buttons() -> void:
	for button in buttons:
		button.visible = true

func hide_buttons() -> void:
	for button in buttons:
		button.visible = false