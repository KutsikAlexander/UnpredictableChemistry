class_name TestTube

extends Draggable

@export_color_no_alpha var color: Color
@export var n: int
var m: int = 0
@onready var label: Label = $Label
@onready var liquid: Sprite2D = $Liquid
@onready var audio_stream: AudioStreamPlayer = $AudioStreamPlayer
var buttons: Array[Button]

signal value_changed

func _ready() -> void:
	super._ready()
	liquid.self_modulate = color
	label.text = "?"
	for button in find_children("*Button*", "Button"):
		if button is Button:
			buttons.append(button)
	hide_buttons()
	picked_up.connect(hide_buttons)
	picked_up.connect(play_sound)

func set_properties(_n: int, _color: Color) -> void:
	self.n = _n
	color = _color
	if is_node_ready():
		liquid.self_modulate = color

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

func play_sound() -> void:
	audio_stream.playing = true