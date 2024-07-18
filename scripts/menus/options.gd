extends PanelContainer

@onready var resolution_selector: OptionButton = $VBoxContainer/HBoxContainer/OptionButton
@onready var full_screen_toggle: CheckButton = $VBoxContainer/HBoxContainer3/CheckButton

func _ready() -> void:
	resolution_selector.text = str(get_window().size.x) + "x" + str(get_window().size.y)
	if get_window().mode == Window.MODE_FULLSCREEN:
		full_screen_toggle.button_pressed = true
	else:
		full_screen_toggle.button_pressed = false
	

func _on_check_button_toggled(toggled_on:bool) -> void:
	if toggled_on:
		get_window().mode = Window.MODE_FULLSCREEN
	else:
		get_window().mode = Window.MODE_WINDOWED

func _on_h_slider_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value - 80)


func _on_option_button_item_selected(index:int) -> void:
	match index:
		0:
			get_window().size = Vector2i(640, 480)
		1:
			get_window().size = Vector2i(1280, 720)
		2:
			get_window().size = Vector2i(1920, 1080)
		_:
			get_window().size = Vector2i(1920, 1080)
