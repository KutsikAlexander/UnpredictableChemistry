class_name Acceptor

extends Area2D

var draggable: Draggable = null

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(other: Area2D) -> void:
	if other is Draggable:
		draggable = other
		draggable.drop.connect(_on_drop)

func _on_area_exited(other: Area2D) -> void:
	if other == draggable:
		draggable.drop.disconnect(_on_drop)
		draggable = null

func _on_drop() -> void:
	pass
