class_name BoardThinker
extends Node

@onready var fade = $CanvasLayer/ColorRect
@onready var animation = $CanvasLayer/AnimationPlayer

func _ready():
	remove_fade()

func remove_fade():
	# TODO: make the fade appear, then disappear from the animation down below
	# also fix timing
	# 20 frames after the fade, display the first thing
	# (unsure if it's just for the icon menu or every action)
	
	animation.play("Fade Out")
