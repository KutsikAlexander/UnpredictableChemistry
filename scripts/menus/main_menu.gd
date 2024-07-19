extends Control

@onready var main_menu_panel = $MainPanelContainer
@onready var options_panel = $OptionsPanelContainer
@onready var select_level_panel = $SelectLevelPanelContainer
@onready var credits_panel = $CreditsPanelContainer

func show_main_menu() -> void:
	main_menu_panel.visible = true
	options_panel.visible = false
	credits_panel.visible = false
	select_level_panel.visible = false

func show_options() -> void:
	main_menu_panel.visible = false
	options_panel.visible = true

func show_credits() -> void:
	main_menu_panel.visible = false
	credits_panel.visible = true

func show_select_level() -> void:
	main_menu_panel.visible = false
	select_level_panel.visible = true

func exit_games() -> void:
	get_tree().quit()
