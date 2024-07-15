class_name Sink

extends Acceptor

func _on_drop() -> void:
    if draggable is Mixer:
        draggable.flush()