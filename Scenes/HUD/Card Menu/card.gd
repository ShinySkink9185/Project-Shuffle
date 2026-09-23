extends Control

@export var type: GlobalStatistics.CardTypes

var showing = false
var hovering = false
var wasHovering = false
var selected = false
var appearing = true

@onready var animation = $AnimationPlayer
@onready var cardImage = $TextureRect

func _ready():
	if appearing == true:
		animation.play("Appear")
	
	if showing == true:
		cardImage.texture.region.position.x = 48 * (type)
	else:
		cardImage.texture.region.position.x = 432

func _process(_delta):
	if hovering == true and wasHovering == false:
		animation.play("Enter Hover")
		wasHovering = true
	elif hovering == false and wasHovering == true:
		animation.play("Exit Hover")
		wasHovering = false
