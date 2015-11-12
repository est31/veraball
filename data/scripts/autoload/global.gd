extends Node

var coins = 0
var coins_total = 0

func _ready():
	# Add HUD
	var hud_scene = preload("res://data/scenes/hud.xscn")
	var hud = hud_scene.instance()
	add_child(hud)
	
	# Add centerprint
	var centerprint_scene = preload("res://data/scenes/hud/centerprint.xscn")
	var centerprint = centerprint_scene.instance()
	add_child(centerprint)

func centerprint(text):
	get_node("/root/CenterPrint/Label").set_text(text)
	get_node("/root/CenterPrint/AnimationPlayer").play("Fade")

func reset_game_state():
	get_tree().reload_current_scene()
	coins = 0