extends Node ## This is our global rememberance of global things in the game.

var characters = [] ## Our total characters that exist in-game.
var boards = [] ## Our total boards that exist in-game.
var movementAbilities = [] ## Our total movement abilities that exist in-game.
var attackAbilities = [] ## Our total attack abilities that exist in-game.

func _ready():
	define_character("res://Assets/Images/Characters/Sonic/sonicDefinition.txt")

class Character: ## Classes for the stats of each Character
	var definition: String
	var name: String
	var image: String
	var iconImage: String
	var movementAbility: String
	var attackAbility: String
	
	var animations: Array
	
	class CharacterAnimation: ## Each individual animation that one character has.
		var name: String ## The name of the animation.
		var frames: Array[int] ## Order of frames.
		var loopPoint: int ## What frame do we loop back to?
		var frameTimes: Array[int] ## How much time should each frame last?
	
	func _init(setDefinition: String):
		definition = setDefinition
		# Read our definition file, and get it as a text message.
		var definitionFile = FileAccess.open(definition, FileAccess.READ)
		var definitionText = definitionFile.get_as_text()
		definitionText = definitionText.remove_chars(" ")
		# We need to add a beginning line here in order to prevent stuff such as
		# setting a character name to "name=e" or something breaking the game
		definitionText = definitionText.insert(0, "\n")
		
		# Get our character's name.
		if definitionText.findn("\nname=") == -1:
			print("ERROR: No name has been given for this character!")
			return
		name = find_argument(definitionText, "\nname=")
		print(name)
		
		# Get our character's image.
		if definitionText.findn("\nimage=") == -1:
			print("ERROR: No image has been given for this character!")
			name = ""
			return
		var imageString = find_argument(definitionText, "\nimage=")
		# Gets the base directory of our character.
		var imagePath = setDefinition.get_base_dir()
		imagePath += "/" + imageString
		# Check if this is a valid path for our image.
		if imagePath.is_absolute_path():
			image = imagePath
		else:
			print("ERROR: Image not found for a character!")
			name = ""
			return
		
		# Get our character's icon image.
		# TODO: denying a character is a bit harsh for not having icons.
		# Have a replacement image filled instead when you can
		if definitionText.findn("\niconImage=") == -1:
			print("ERROR: No icons have been given for this character!")
			name = ""
			return
		var iconImageString = find_argument(definitionText, "\niconImage=")
	
	func find_argument(definitionText: String, text: String): ## Help us find an argument!
		var firstIndex = definitionText.findn(text)
		var lastIndex = definitionText.findn("\n", firstIndex + 1)
		var ans = definitionText
		ans = ans.left(lastIndex)
		ans = ans.substr(firstIndex)
		ans = ans.replace(text, "")
		return ans
		

func define_character(definition: NodePath): ## Defines a character that can be added to the game.
	var character = Character.new(definition)
	# Only add our character if their name isn't blank.
	if character.name != "":
		characters.append(character)
	
