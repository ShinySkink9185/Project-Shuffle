extends TextureRect
class_name ShufflePlayerIcon

# TODO: when the character is switched or when the player is initialized, reload all of our animations
var character: String = "sonic" ## Which character are we dealing with?
var characterID: int = 0 ## Internally, what character ID are we using?

var playerIDStored: int = 1

@export var playerID: int = 1 ## What player is attached to this guy?

func _ready():
	change_icon()

# Detect changes in character and sort things out again.
func _process(_delta):
	if playerIDStored != playerID:
		change_icon()

func change_icon():
	characterID = 0
	
	# Change our character ID string over here.
	character = GameStatistics.players_info[playerID - 1]["Character"]
	
	# First, we need to check if our character is valid.
	var characterFound = false
	
	for currentCharacter in GlobalStatistics.characters:
		if currentCharacter.id == character:
			characterFound = true
			break
		characterID += 1
	
	if characterFound == false:
		print("ERROR: Character " + character + " not found! Reverting to Sonic.")
		character = "sonic"
		characterID = 0
	
	# Now, load our image from our character and adjust our region.
	texture.atlas = load(GlobalStatistics.characters[characterID].iconImage)
	texture.region = Rect2(4, 4, 72, 72)
	
	playerIDStored = playerID
