extends Control

@export var type: GlobalStatistics.CardTypes = GlobalStatistics.CardTypes.ONE

var showing = true
var hovering = false
var wasHovering = false
var selected = false
var appearing = false

signal finished_appearing

@onready var animation = $AnimationPlayer
@onready var cardImage = $TextureRect

func _ready():
	if appearing == true:
		animation.play("Appear")
	
	if showing == true:
		cardImage.texture.region.position.x = 48 * (type - 1)
	else:
		cardImage.texture.region.position.x = 432

func _process(_delta):
	if hovering == true and wasHovering == false:
		animation.play("Enter Hover")
		wasHovering = true
	elif hovering == false and wasHovering == true:
		animation.play("Exit Hover")
		wasHovering = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Appear":
		print(anim_name)
		# TODO: fix this...
		print("Finished appearing!")
		finished_appearing.emit()
