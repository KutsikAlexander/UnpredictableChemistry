class_name Sink

extends Acceptor

func _on_drop() -> void:
	for mixer in draggable.find_children("*Acceptor*", "Mixer"):
		if mixer is Mixer:
			mixer.flush()