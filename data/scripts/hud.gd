extends Control

var global
var coins
var coins_total

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	global = get_node("/root/Global")
	coins = global.coins
	coins_total = global.coins_total

	get_node("Coins/CoinsCount").set_text(str(coins))
	get_node("FramesPerSecond").set_text(str(OS.get_frames_per_second()) + " FPS")
	get_node("Coins/CoinsProgress").set_value(int(coins))
	get_node("Coins/CoinsProgress").set_max(int(coins_total))
