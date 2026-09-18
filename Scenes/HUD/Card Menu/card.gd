extends Control

enum CardTypes {ONE, TWO, THREE, FOUR, FIVE, SIX, SPECIAL, EGGMAN, EGGMAN_FOUR}
@export var type: CardTypes

var showing = false
var hovering = true
var selected = false
var appearing = false

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
	if hovering == true:
		if animation.current_animation == "Idle" or animation.current_animation == "Exit Hover":
			animation.play("Enter Hover")
		else:
			animation.play("Hover")
	else:
		if animation.current_animation == "Hover" or animation.current_animation == "Enter Hover":
			animation.play("Exit Hover")
		else:
			animation.play("Idle")
		
