class_name Draggable

extends Area2D

var in_focus: bool = false
var dragged: bool = false
var original_position: Vector2
var mouse_position: Vector2

signal picked_up
signal drop

func _ready() -> void:
	mouse_entered.connect(on_mouse_enter)
	mouse_exited.connect(on_mouse_exit)
	original_position = position

func _process(delta: float) -> void:
	if dragged:
		position = mouse_position
	else:
		position = original_position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if in_focus:
			dragged = !dragged
		if dragged:
			picked_up.emit()
		else:
			drop.emit()

	if event is InputEventMouseMotion:
		mouse_position = to_global(to_local(event.position))

func on_mouse_enter() -> void:
	in_focus = true

func on_mouse_exit() -> void:
	in_focus = false
