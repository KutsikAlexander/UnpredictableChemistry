extends Node

var min_level:int = 3
var max_level:int = 12
var level:int = 3

@onready var increase_button: Button = $VBoxContainer/HBoxContainer/IncreaseButton
@onready var decrease_button: Button = $VBoxContainer/HBoxContainer/DecreaseButton
@onready var level_label: Label = $VBoxContainer/HBoxContainer/Label

func increase_level() -> void:
	if level < max_level:
		level += 1
		change_level()

func decrease_level() -> void:
	if level > min_level:
		level -= 1
		change_level()

func change_level() -> void:
	if level == min_level:
		decrease_button.disabled = true
	elif level == max_level:
		increase_button.disabled = true
	else:
		decrease_button.disabled = false
		increase_button.disabled = false
	level_label.text = str(level)


func load_level() -> void:
	Lab.N = level
	get_tree().change_scene_to_file("res://scenes/lab.tscn")
