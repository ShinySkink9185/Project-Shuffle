extends Node ## This is our global rememberance of global things in the game.
class_name Global_Statistics

static var movementAbilities = [] ## Our total movement abilities that exist in-game.
static var attackAbilities = [] ## Our total attack abilities that exist in-game.
static var characters = [] ## Our total characters that exist in-game.
static var boards = [] ## Our total boards that exist in-game.

func _ready():
	# Movement Ability definitions
	# (How they play in-game is defined by the player node; this just recognizes their existence, mostly.)
	define_movement_ability("N/A", "", "")
	define_movement_ability("SPIN_DASH", "Spin Dash", "Play the same number twice in a row to move double the number displayed on the 2nd turn.")
	define_movement_ability("PROPELLER_FLIGHT", "Propeller Flight", "You can move across [Tails' Space].")
	define_movement_ability("CLIMBING", "Climbing", "You can move across [Knuckles' Space].")
	define_movement_ability("HAMMER_JUMP", "Hammer Jump", "You can move across [Amy's Space].")
	define_movement_ability("FROGGY", "Froggy", "Play the number 6, and you can step on any space within a range of 1-6 spaces.")
	define_movement_ability("ROLLING_MODE", "Rolling Mode", "Play a 4, 5 or 6 and you won't be affected by -[Ring] spaces.")
	define_movement_ability("LIGHT_SPEED_SPIN_DASH", "Light-Speed Spin Dash", "In addition to Spin Dash, you will move double the number displayed on the 3rd and 4th turns.")
	
	# Attack Ability definitions
	# (How they play in-game is defined by the player node; this just recognizes their existence, mostly.)
	define_attack_ability("N/A", "", "")
	define_attack_ability("LIGHT_SPEED_SPIN_ATTACK", "Light-speed Spin Attack", "Use the [S] during a battle to attack with the numbers between 1-S(7).")
	define_attack_ability("RAPID_SPIN_ATTACK", "Rapid Spin Attack", "Use the [S] during a battle to attack with [two cards].")
	define_attack_ability("MAXIMUM_HEAT_ATTACK", "Maximum Heat Attack", "Use the [S] during battle to attack with [two cards].")
	define_attack_ability("REVOLVING_HAMMER_ATTACK", "Revolving Hammer Attack", "Use the [S] during battle to do 5 damage to the enemy.")
	define_attack_ability("POWER_THROW", "Power Throw", "Use the [S] during battle and add 1 damage to your total attack damage.")
	define_attack_ability("GUN", "Gun", "Use the [S] during battle to attack using [two cards] of numbers between 1-3.")
	define_attack_ability("LULLABY", "Lullaby", "Use the [S] during battle, and you won't take damage from the monster if you lose.")
	define_attack_ability("SONIC_RUMBLE", "Sonic Rumble", "Use the [S] during battle to attack with cards between 4-6.")
	
	# Character definitions
	define_character("res://Assets/Images/Characters/Sonic/sonicDefinition.txt")
	
	# Board definitions
	
class MovementAbility: ## Classes for each Movement Ability
	var id: String ## The identifier of the animation.
	var name: String ## The name/identifier of the animation.
	var description: String ## What the information of the ability contains in the dialogue.
	# TODO: Have the description String be able to accept image parameters.
	# I think RichTextLabels might have something to do with it?
	
	func _init(setID: String, setName: String, setDescription: String):
		id = setID.to_lower()
		name = setName
		description = setDescription

func define_movement_ability(setID: String, setName: String, setDescription: String): ## Defines a character that can be added to the game.
	var movementAbility = MovementAbility.new(setID, setName, setDescription)
	# Only add our ability if its ID isn't blank.
	if movementAbility.id != "":
		if movementAbility.name == "" && movementAbility.id != "N/A":
			movementAbility.name = movementAbility.id.capitalize()
		movementAbilities.append(movementAbility)
	
class AttackAbility: ## Classes for each Attack Ability
	var id: String ## The identifier of the animation.
	var name: String ## The name/identifier of the animation.
	var description: String ## What the information of the ability contains in the dialogue.
	# TODO: Have the description String be able to accept image parameters.
	# I think RichTextLabels might have something to do with it?
	
	func _init(setID: String, setName: String, setDescription: String):
		id = setID.to_lower()
		name = setName
		description = setDescription

func define_attack_ability(setID: String, setName: String, setDescription: String): ## Defines a character that can be added to the game.
	var attackAbility = AttackAbility.new(setID, setName, setDescription)
	# Only add our ability if its ID isn't blank.
	if attackAbility.id != "":
		if attackAbility.name == "" && attackAbility.id != "N/A":
			attackAbility.name = attackAbility.id.capitalize()
		attackAbilities.append(attackAbility)

class Character: ## Classes for the stats of each Character
	var definition: String
	var id: String
	var name: String
	var image: String
	var iconImage: String
	var movementAbility: String
	var attackAbility: String
	
	# We have to copy-paste the table of all of our existing abilities here because
	# we can't just call the variables from our base class in the inner one...
	var movementAbilities = []
	var attackAbilities = []
	
	# Animation stuff.
	var animations: Array
	
	class CharacterAnimation: ## Each individual animation that one character has.
		var name: String ## The name of the animation.
		var frames: Array[int] ## Order of frames.
		var loopPoint: int ## What frame do we loop back to?
		var frameTimes: Array[int] ## How much time should each frame last?
	
	func _init(setDefinition: String, mainNode):
		# Handle our main node's abilties lists
		movementAbilities = mainNode.movementAbilities
		attackAbilities = mainNode.attackAbilities
		
		definition = setDefinition
		# Read our definition file, and get it as a text message.
		var definitionFile = FileAccess.open(definition, FileAccess.READ)
		var definitionText = definitionFile.get_as_text()
		definitionText = definitionText.remove_chars(" ")
		# We need to add a beginning line here in order to prevent stuff such as
		# setting a character name to "name=e" or something breaking the game
		definitionText = definitionText.insert(0, "\n")
		
		# Get our character's ID.
		# TODO: Compare the ID of the character with others to make sure it's not replacing anything.
		# TODO: Or, make it so defining an existing character modifies that character's parameters...
		if definitionText.findn("\nid=") == -1:
			print("ERROR: No ID has been given for this character!")
			return
		id = (find_argument(definitionText, "\nid=")).to_lower()
		
		# Get our character's name.
		if definitionText.findn("\nname=") == -1:
			print("ERROR: No name has been given for this character! Defaulting to their ID.")
			name = id.capitalize()
		else:
			name = find_argument(definitionText, "\nname=")
		
		# Get our character's movement ability (if it's a valid one, of course!)
		# NOTICE: Maybe it would be cool to have custom abilities? Dunno how
		# that'd work, though - not a priority
		if definitionText.findn("\nmovementAbility=") == -1:
			print('ERROR: No movement ability has been given for this character! Defaulting to "N/A".')
			movementAbility = "N/A"
		else:
			# We have a potentially valid movement ability. Let's see if it actually exists in our list...
			var potentialMovementAbility = find_argument(definitionText, "\nmovementAbility=").to_lower()
			for currentMovementAbility in movementAbilities:
				if currentMovementAbility.id.to_lower() == potentialMovementAbility:
					movementAbility = potentialMovementAbility
					break
			if movementAbility == null:
				print('ERROR: Invalid movement ability! Defaulting to "N/A".')
				movementAbility = "N/A"
		
		# Get our character's attack ability (if it's a valid one, of course!)
		# NOTICE: Maybe it would be cool to have custom abilities? Dunno how
		# that'd work, though - not a priority
		if definitionText.findn("\nattackAbility=") == -1:
			print('ERROR: No attack ability has been given for this character! Defaulting to "N/A".')
			attackAbility = "N/A"
		else:
			# We have a potentially valid attack ability. Let's see if it actually exists in our list...
			var potentialAttackAbility = find_argument(definitionText, "\nattackAbility=").to_lower()
			for currentAttackAbility in attackAbilities:
				if currentAttackAbility.id.to_lower() == potentialAttackAbility:
					attackAbility = potentialAttackAbility
					break
			if attackAbility == null:
				print('ERROR: Invalid attack ability! Defaulting to "N/A".')
				attackAbility = "N/A"
		
		# Get our character's image.
		if definitionText.findn("\nimage=") == -1:
			print("ERROR: No image has been given for this character!")
			id = ""
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
			id = ""
			return
		
		# Get our character's icon image.
		# TODO: denying a character is a bit harsh for not having icons.
		# Have a replacement image filled instead when you can
		if definitionText.findn("\niconImage=") == -1:
			print("ERROR: No icons have been given for this character!")
			id = ""
			return
		var iconImageString = find_argument(definitionText, "\niconImage=")
		# Gets the base directory of our character.
		var iconImagePath = setDefinition.get_base_dir()
		iconImagePath += "/" + iconImageString
		# Check if this is a valid path for our image.
		if iconImagePath.is_absolute_path():
			iconImage = iconImagePath
		else:
			print("ERROR: Icon image not found for a character!")
			name = ""
			return
	
	func find_argument(definitionText: String, text: String): ## Help us find an argument!
		var firstIndex = definitionText.findn(text)
		var lastIndex = definitionText.findn("\n", firstIndex + 1)
		var ans = definitionText
		ans = ans.left(lastIndex)
		ans = ans.substr(firstIndex)
		ans = ans.replace(text, "")
		return ans
		

func define_character(definition: NodePath): ## Defines a character that can be added to the game.
	var character = Character.new(definition, self)
	# Only add our character if their ID isn't blank.
	if character.id != "":
		characters.append(character)
	
