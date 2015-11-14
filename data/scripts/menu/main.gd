extends Control

var global
var hud_scene
var centerprint_scene

var current_menu

func _ready():
	global = get_node("/root/Global")
	hud_scene = get_node("/root/Global/HUD")
	centerprint_scene = get_node("/root/Global/CenterPrint")
	set_process_input(true)
	
	# Hide HUD in main menu
	hud_scene.hide()
	centerprint_scene.hide()
	# Reset coin count to 0:
	global.coins = 0
	global.clock_running = true
	
func _on_PlayButton_pressed():
	global.start_game("basics")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_FPSLimitLineEdit_text_changed(text):
	# Prevent too low FPS limit
	if int(text) > 10:
		OS.set_target_fps(int(text))
	else:
		OS.set_target_fps(10)

func _on_OptionsButton_pressed():
	handle_menu_change("OptionsMenu")

func _on_HelpButton_pressed():
	handle_menu_change("HelpMenu")

func handle_menu_change(new_menu):
	# If there is no menu opened, there is no menu to hide
	if current_menu != null:
		get_node(current_menu).hide()
	get_node(new_menu).show()
	current_menu = new_menu
