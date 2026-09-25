extends Control

@export var type: GlobalStatistics.CardTypes = GlobalStatistics.CardTypes.ONE

var showing = true
var hovering = false
var wasHovering = false
var selected = false
var appearing = false

@onready var animation = $AnimationPlayer
@onready var cardImage = $TextureRect

func _ready():
	if appearing == true:
		animation.play("Appear")
	
	if showing == true:
		cardImage.texture.region.position.x = 48 * (type - 1)
	else:
		cardImage.texture.region.position.x = 432
	
	print(type)

func _process(_delta):
	if hovering == true and wasHovering == false:
		animation.play("Enter Hover")
		wasHovering = true
	elif hovering == false and wasHovering == true:
		animation.play("Exit Hover")
		wasHovering = false
