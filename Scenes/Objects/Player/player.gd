extends CharacterBody3D ## Playable characters for all intents and purposes.

# TODO: when the character is switched or when the player is initialized, reload all of our animations
var character: String = "sonic" ## Which character are we dealing with?
var characterID: int = 0 ## Internally, what character ID are we using?
var playerID: int = 0 ## What player is attached to this guy?
var state: String ## What state are we in?

@onready var sprite = $Sprite3D
@onready var animation = $Sprite3D/AnimationPlayer

func _ready():
	refresh_animations()

func refresh_animations(): ## Refreshes all animations when changing characters.
	# First, we need to check if our character is valid.
	var characterFound = false
	
	for currentCharacter in Global_Statistics.characters:
		if currentCharacter.id == character:
			characterFound = true
			break
		characterID += 1
	
	if characterFound == false:
		print("ERROR: Character " + character + " not found! Reverting to Sonic.")
		character = "sonic"
		characterID = 0
	
	var usedCharacter = Global_Statistics.characters[characterID] # Just for easier access.
	
	# Now, we need to set up our sprites.
	var characterImage = load(usedCharacter.image)
	sprite.texture = characterImage
	sprite.hframes = characterImage.get_width() / usedCharacter.boxWidth
	sprite.hframes = characterImage.get_height() / usedCharacter.boxHeight
	
	# TODO: add animations
	
