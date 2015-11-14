extends Node

var coins = 0
var coins_total = 0
var coins_required = 0
var game_time = 0.0
var clock_running = true

func _ready():
	set_fixed_process(true)
	# Add HUD
	var hud_scene = preload("res://data/scenes/hud.xscn")
	var hud = hud_scene.instance()
	add_child(hud)
	
	# Add centerprint
	var centerprint_scene = preload("res://data/scenes/hud/centerprint.xscn")
	var centerprint = centerprint_scene.instance()
	add_child(centerprint)

func _fixed_process(delta):
	if clock_running:
		game_time += delta

func centerprint(text):
	get_node("/root/Global/CenterPrint").show()
	get_node("/root/Global/CenterPrint/Label").set_text(text)
	get_node("/root/Global/CenterPrint/AnimationPlayer").play("Fade")

func reset_game_state():
	get_tree().reload_current_scene()
	coins = 0
	game_time = 0
	clock_running = true

func start_game(map):
	get_tree().change_scene("res://data/scenes/maps/" + map + ".xscn")
	get_node("/root/Global/HUD").show()
	game_time = 0

func go_to_main_menu():
	get_tree().change_scene("res://data/scenes/menu/main.xscn")
	clock_running = true
	game_time = 0
	get_node("/root/Global/HUD").hide()
	get_node("/root/Global/CenterPrint").hide()