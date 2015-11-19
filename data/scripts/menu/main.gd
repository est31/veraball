extends Control

var global
var hud_scene
var centerprint_scene

# For setting up OptionButtons
var shadow_type
var language

var current_menu

func handle_menu_change(new_menu):
	# If there is no menu opened, there is no menu to hide
	if current_menu != null:
		get_node(current_menu).hide()
	get_node(new_menu).show()
	current_menu = new_menu

func setup_shadow_type_optionbutton():
	shadow_type = get_node("OptionsMenu/OptionsPanel/ShadowType/OptionButton")
	shadow_type.add_item(tr("ShadowsNone"))		# 0
	shadow_type.add_item(tr("ShadowsPCF5"))		# 1
	shadow_type.add_item(tr("ShadowsPCF13"))	# 2
	shadow_type.add_item(tr("ShadowsESM"))		# 3
	# Select the current shadow filter when loading scene
	shadow_type.select(Globals.get("rasterizer/shadow_filter"))

func setup_language_optionbutton():
	language = get_node("OptionsMenu/OptionsPanel/Language/OptionButton")
	language.add_item("English")	# 0
	language.add_item("Français")	# 1
	language.select(locale_to_id(TranslationServer.get_locale()))

func locale_to_id(locale):
	if locale == "fr" or locale == "fr_FR":
		return 1
	else:
		return 0

func hide_all_menus():
	for node in get_tree().get_nodes_in_group("Menu"):
		node.hide()

func _ready():
	global = get_node("/root/Global")
	hud_scene = get_node("/root/Global/HUD")
	centerprint_scene = get_node("/root/Global/CenterPrint")
	set_process_input(true)
	
	# Hide all menus
	hide_all_menus()
	
	# Hide HUD in main menu
	hud_scene.hide()
	centerprint_scene.hide()
	# Reset coin count to 0:
	global.coins = 0
	global.clock_running = true
	
	setup_shadow_type_optionbutton()
	setup_language_optionbutton()
	
func _on_PlayButton_pressed():
	global.start_game("basics")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_FPSLimit_text_changed(text):
	# Prevent too low FPS limit
	if int(text) > 10:
		OS.set_target_fps(int(text))
	else:
		OS.set_target_fps(10)

func _on_OptionsButton_pressed():
	handle_menu_change("OptionsMenu")

func _on_HelpButton_pressed():
	handle_menu_change("HelpMenu")

func _on_ShadowType_item_selected(ID):
	Globals.set("rasterizer/shadow_filter", ID)

func _on_Language_item_selected(ID):
	var locale
	if ID == 0:
		locale = "en"
	elif ID == 1:
		locale = "fr"
	TranslationServer.set_locale(locale)
	get_tree().reload_current_scene()
