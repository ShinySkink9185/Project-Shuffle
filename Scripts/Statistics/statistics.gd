extends Node ## This is our global rememberance of our players.

var characters = [] ## Our total characters that exist in-game.
var boards = [] ## Our total boards that exist in-game.
var movementAbilities = [] ## Our total movement abilities that exist in-game.
var attackAbilities = [] ## Our total attack abilities that exist in-game.

func _ready():
	define_character("res://Assets/Images/Characters/Sonic/sonicDefinition.txt")

func define_character(definition: NodePath): ## Defines a character that can be added to the game.
	pass
