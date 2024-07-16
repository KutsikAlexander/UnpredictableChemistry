class_name TestTube

extends Draggable

@export_color_no_alpha var color: Color
@export var n: int
var m: int = 0
@export var N: int
@onready var label: Label = $Label
@onready var liquid: Sprite2D = $Liquid
@onready var audio_stream: AudioStreamPlayer = $AudioStreamPlayer
@export var pick_sound: AudioStream
@export var change_value_sound: AudioStream
@onready var up_button: Button = $UpButton
@onready var down_button: Button = $DownButton

signal value_changed

func _ready() -> void:
	super._ready()
	liquid.self_modulate = color
	label.text = "?"
	label.tooltip_text = "Color: #" + str(color.to_html(false))
	down_button.disabled = true
	hide_buttons()
	picked_up.connect(hide_buttons)
	picked_up.connect(play_sound)

func set_properties(_n: int, _color: Color, _N: int) -> void:
	self.n = _n
	self.color = _color
	self.N = _N
	if is_node_ready():
		liquid.self_modulate = color

func increase_value() -> void:
	if m < N:
		m+=1
		change_value()


func decrease_value() -> void:
	if m > 0:
		m-=1
		change_value()
	
func change_value() -> void:
		value_changed.emit()
		label.text = str(m)
		audio_stream.stream = change_value_sound
		audio_stream.playing = true
		if m == 0:
			label.text = "?"
			down_button.disabled = true
		elif m == N:
			up_button.disabled = true
		else:
			up_button.disabled = false
			down_button.disabled = false

func show_buttons() -> void:
	up_button.visible = true
	down_button.visible = true

func hide_buttons() -> void:
	up_button.visible = false
	down_button.visible = false

func play_sound() -> void:
	audio_stream.stream = pick_sound
	audio_stream.playing = true