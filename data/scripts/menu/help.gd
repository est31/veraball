extends Control

var text = "[color=#ffff00]" + tr("HelpControlsTitle") + "[/color]" + "\n\n" \
+ tr("HelpControlTheBall") + "\n" \
+ tr("HelpJump")

func _ready():
	get_node("HelpPanel/Text").set_bbcode(text)
