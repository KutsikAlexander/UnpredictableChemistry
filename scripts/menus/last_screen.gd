extends CanvasLayer

func go_back_to_main_menu() -> void:
    get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")