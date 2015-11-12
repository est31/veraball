extends Spatial

var global

func _ready():
	global = get_node("/root/Global")
	global.coins_total = 20

func _on_WelcomeToVeraball_body_enter(body):
	global.centerprint("WelcomeToVeraball")

func _on_Reset_body_enter(body):
	global.reset_game_state()