class_name Draggable

extends Area2D

var in_focus: bool = false
var is_intercept: bool = false
var dragged: bool = false
var original_position: Vector2
var mouse_position: Vector2

signal picked_up
signal drop

func _ready() -> void:
	mouse_entered.connect(on_mouse_enter)
	mouse_exited.connect(on_mouse_exit)
	original_position = position

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed() and in_focus:
			dragged = true
		if event.is_released():
			dragged = false

		if dragged:
			picked_up.emit()
			global_position = mouse_position
			z_index=2
		else:
			drop.emit()
			position = original_position
			z_index=0

	if event is InputEventMouseMotion:
		mouse_position = to_global(to_local(event.position))
		if dragged:
			global_position = mouse_position
		else:
			position = original_position

func on_mouse_enter() -> void:
	in_focus = true

func on_mouse_exit() -> void:
	in_focus = false