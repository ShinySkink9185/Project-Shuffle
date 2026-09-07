class_name BoardThinker
extends Node

@onready var fade = $CanvasLayer/ColorRect
@onready var animation = $CanvasLayer/AnimationPlayer

func _ready():
	remove_fade()
	# Wait for our fadeout to finish
	await animation.animation_finished
	# Wait for 20 frames
	await get_tree().create_timer(20.0/30.0).timeout
	# Get our first Icon Menu in there
	# TODO: account for other things in the game; this only takes care of startup
	# maybe move this to a separate "actions" function?
	var icon_menu = load("res://Scenes/HUD/Icon Menu/icon_menu.tscn")
	var icon_menu_instance = icon_menu.instantiate()
	icon_menu_instance.type = icon_menu_instance.IconMenuTypes.BOARD
	get_parent().add_child(icon_menu_instance)

func remove_fade():
	# TODO: make the fade appear, then disappear from the animation down below
	# also fix timing
	# 20 frames after the fade, display the first thing
	# (unsure if it's just for the icon menu or every action)
	
	animation.play("Fade Out")
