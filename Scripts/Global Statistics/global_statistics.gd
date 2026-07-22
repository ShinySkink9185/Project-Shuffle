extends Node ## This is our global rememberance of global things in the game.
class_name Global_Statistics

static var movementAbilities = [] ## Our total movement abilities that exist in-game.
static var attackAbilities = [] ## Our total attack abilities that exist in-game.
static var characterAnimations = [] ## Our valid character animation names that exist in-game.
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
	
	# Character animation definitions
	# "STAND" can loop back to itself because we have detection for that, it kinda needs to exist
	# As a rule of thumb, we don't want to have a situation where one animation falls back to another that
	# then falls back to that same animation. That'd probably freeze the game
	define_character_animation("stand", "n/a")
	define_character_animation("wait", "stand")
	define_character_animation("walk", "stand")
	define_character_animation("run", "walk")
	define_character_animation("jump", "stand")
	define_character_animation("fall", "jump")
	define_character_animation("alert", "stand")
	define_character_animation("drink", "wait")
	define_character_animation("hurt", "fall")
	define_character_animation("victory", "wait")
	define_character_animation("stand_sad", "stand")
	define_character_animation("walk_sad", "walk")
	define_character_animation("defeat", "wait")
	
	# Character definitions
	define_character("res://Assets/Character Definitions/Sonic/sonicDefinition.txt")
	
	# Board definitions
	
class MovementAbility: ## Classes for each Movement Ability
	var id: String ## The identifier of the ability that is used internally.
	var name: String ## The name of the ability that shows up in-game.
	var description: String ## What the information of the ability contains in the dialogue.
	# TODO: Have the description String be able to accept image parameters.
	# I think RichTextLabels might have something to do with it?
	
	func _init(setID: String, setName: String, setDescription: String):
		id = setID.to_lower()
		name = setName
		description = setDescription

func define_movement_ability(setID: String, setName: String, setDescription: String): ## Defines a movement ability that can be added to the game.
	var movementAbility = MovementAbility.new(setID, setName, setDescription)
	# Only add our ability if its ID isn't blank.
	if movementAbility.id != "":
		if movementAbility.name == "" && movementAbility.id != "N/A":
			movementAbility.name = movementAbility.id.capitalize()
		movementAbilities.append(movementAbility)
	
class AttackAbility: ## Classes for each Attack Ability
	var id: String ## The identifier of the ability that is used internally.
	var name: String ## The name of the ability that shows up in-game.
	var description: String ## What the information of the ability contains in the dialogue.
	# TODO: Have the description String be able to accept image parameters.
	# I think RichTextLabels might have something to do with it?
	
	func _init(setID: String, setName: String, setDescription: String):
		id = setID.to_lower()
		name = setName
		description = setDescription

func define_attack_ability(setID: String, setName: String, setDescription: String): ## Defines an attack ability that can be added to the game.
	var attackAbility = AttackAbility.new(setID, setName, setDescription)
	# Only add our ability if its ID isn't blank.
	if attackAbility.id != "":
		if attackAbility.name == "" && attackAbility.id != "N/A":
			attackAbility.name = attackAbility.id.capitalize()
		attackAbilities.append(attackAbility)

class CharacterAnimation: ## Classes for each character animation
	var id: String ## The identifier for each animation.
	var fallbackID: String ## What animation will this fall back to if a character doesn't have this?
	
	func _init(setID: String, setFallbackID: String):
		id = setID.to_lower()
		fallbackID = setFallbackID.to_lower()

func define_character_animation(setID: String, setFallbackID: String): ## Defines a character animation that can be added to the game.
	var characterAnimation = CharacterAnimation.new(setID, setFallbackID)
	# Only add our ability if it's ID doesn't match up with anything else.
	# TODO: do that for our other things
	# By the way, we don't check if the fallback ID's animation exists because what if that's added later?
	# It's probably better if that's checked when it's trying to be used rather than when the animation's created.
	
	for currentAnimation in characterAnimations:
		if currentAnimation.id == characterAnimation.id:
			print('ERROR: A character animation already exists with the name "' + currentAnimation.id + '"!')
			return
	
	characterAnimations.append(characterAnimation)

class CharacterAnimationStorage: ## Each individual animation that one character has.
		var id: String ## The identifier of the animation.
		var frames: Array[int] ## Order of frames.
		var loopPoint: int ## What frame do we loop back to?
		var frameTimes: Array[float] ## How much time should each frame last, in seconds?
		
		func _init(setID: String, setFrames: Array[int], setLoopPoint: int, setFrameTimes: Array[float]):
			id = setID
			frames = setFrames
			loopPoint = setLoopPoint
			frameTimes = setFrameTimes

class Character: ## Classes for the stats of each Character
	var definition: String
	var id: String
	var name: String
	var movementAbility: String
	var attackAbility: String
	
	# We have to copy-paste the table of all of our existing abilities here because
	# we can't just call the variables from our base class in the inner one...
	var movementAbilities = []
	var attackAbilities = []
	var characterAnimations = []
	
	# Image stuff
	var image: String
	var iconImage: String
	var boxWidth: int
	var boxHeight: int
	
	# Animation stuff.
	var spriteList: String
	var animations: Array
	
	func _init(setDefinition: String, mainNode):
		# Handle our main node's abilties lists
		movementAbilities = mainNode.movementAbilities
		attackAbilities = mainNode.attackAbilities
		characterAnimations = mainNode.characterAnimations
		
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
			print("ERROR: Icon image not found for this character!")
			id = ""
			return
		
		# Get our character's box width.
		if definitionText.findn("\nboxWidth=") == -1:
			print("ERROR: No box width has been given for this character! Defaulting to 64.")
			boxWidth = 64
		else:
			boxWidth = find_argument(definitionText, "\nboxWidth=").to_int()
		
		# Get our character's box height.
		if definitionText.findn("\nboxHeight=") == -1:
			print("ERROR: No box height has been given for this character! Defaulting to 64.")
			boxHeight = 64
		else:
			boxHeight = find_argument(definitionText, "\nboxHeight=").to_int()
		
		# TODO: Animation data
		# Get our character's animation data. This'll be pretty complex...!
		if definitionText.findn("\nspriteList=") == -1:
			print("ERROR: No animations have been given for this character!")
			id = ""
			return
		spriteList = (find_argument(definitionText, "\nspriteList=")).to_lower()
		print(spriteList)
		
		var spriteListArray = spriteList.split(",", false) # A list of all of the animations that we have for this character.
		
		# Here comes the tricky part: getting all of our animations!
		for currentAnimation in spriteListArray:
			var setID: String ## The identifier of the animation.
			var setFrames: Array[int] ## Order of frames.
			var setLoopPoint: int ## What frame do we loop back to?
			var setFrameTimes = [] ## How much time should each frame last, in seconds?
			
			# First, we need the ID. Simple enough.
			setID = currentAnimation
			
			# Now, this is a little trickier; we have to find the corresponding name section,
			# and get our frames, looppoints, and times from that.
			# TODO: do that
			
			# Starting with our frames...
			# TODO: Account for situations where there would be more than one dash per comma,
			# and for negative numbers. We shouldn't have either of those.
			if definitionText.findn("\n" + setID + "Frames=") == -1:
				print("ERROR: This character's " + '"' + setID + '"' + " animation doesn't have set frames!")
				setFrames = [0]
			else:
				# RULES:
				# Commas separate frames. (0, 1, 2)
				# When adding a dash, cover all sprites from an area. (0-3, 4)
				var setFrameText = find_argument(definitionText, "\n" + setID + "Frames=")
				var setFrameArray = setFrameText.split(",", false) # A list of all of the frames that we have for this animation.
				setFrameArray = Array(setFrameArray) # We have to do this because we can't modify a PackedStringArray for some reason...
				while setFrameArray:
					if setFrameArray[0] is String: # We have to check for a string first...
						if "-" in setFrameArray[0]:
							# This is a hacky solution since I can't just append array entries anywhere for whatever reason...
							var individualNumbers = get_in_between_numbers(setFrameArray[0])
							setFrameArray.pop_front() # Removes the first index...
							individualNumbers.append_array(setFrameArray) # ...appends our array...
							setFrameArray = individualNumbers # ...and sets that array!
						else:
							setFrames.append(setFrameArray[0].to_int()) # Add this frame to our final frame array.
							setFrameArray.pop_front() # Removes the first element in the array.
					else: # We can't have a dash if it's an integer!
						setFrames.append(setFrameArray[0]) # Add this frame to our final frame array.
						setFrameArray.pop_front() # Removes the first element in the array.
			
			# Now, we need our loop point...
			if definitionText.findn("\n" + setID + "LoopPoint=") == -1:
				# No error text this time, since people may intentionally leave this blank
				setLoopPoint = 0
			else:
				var potentialLoopPoint = find_argument(definitionText, "\n" + setID + "LoopPoint=").to_int()
				if potentialLoopPoint > setFrames.size() - 1:
					print("ERROR: The loop point is greater than the amount of frames there are!")
					setLoopPoint = 0
				else:
					setLoopPoint = potentialLoopPoint
			
			# Next, we need either our SPEED or our FRAME TIMES.
			# FRAME TIMES are prioritized over SPEED.
			# Where SPEED is "this animation takes # seconds to finish",
			# FRAME TIMES are "each frame takes # seconds to finish".
			if definitionText.findn("\n" + setID + "FrameTimes=") == -1:
				var totalSpeed: float = 1 # Our template in case we have nothing to work with
				
				if definitionText.findn("\n" + setID + "Speed=") == -1: # Neither SPEED nor FRAMETIMES are present
					print('ERROR: This character does not have any Frame Times or Speed settings in animation "' + setID + '"!')
				else: # SPEED is present
					totalSpeed = find_argument(definitionText, "\n" + setID + "Speed=").to_float()
					if totalSpeed <= 0:
						print('ERROR: Total speed cannot be 0 or less!')
						totalSpeed = 1
				
				var individualSpeeds = float(totalSpeed / setFrames.size())
				for frame in setFrames:
					setFrameTimes.append(individualSpeeds)
					
			else: # FRAMETIMES are present
				var setFrameTimesText = find_argument(definitionText, "\n" + setID + "FrameTimes=")
				setFrameTimes = setFrameTimesText.split(",", false) # A list of all of the times that we have for our frames.
				setFrameTimes = Array(setFrameTimes) # This thing again...
				
				var currentFrame: int = 0
				for frameTime in setFrameTimes:
					setFrameTimes[currentFrame] = setFrameTimes[currentFrame].to_float()
					if setFrameTimes[currentFrame] <= 0:
						print('ERROR: A frame time cannot be 0 or less!')
						if setFrameTimes[currentFrame] == 0:
							setFrameTimes.remove_at(currentFrame)
							setFrameTimes.insert(currentFrame, 0.1)
						setFrameTimes[currentFrame] = -setFrameTimes[currentFrame]
					currentFrame += 1
				
				if setFrameTimes.size() < setFrames.size():
					print("ERROR: FrameTimes size is less than amount of frames! Did you check your frame amount properly?")
					while setFrameTimes.size() < setFrames.size():
						setFrameTimes.append(0.1)
				elif setFrameTimes.size() > setFrames.size():
					print("NOTICE: FrameTimes size is more than amount of frames.")
					while setFrameTimes.size() > setFrames.size():
						setFrameTimes.pop_back()
			
			setFrameTimes = Array(setFrameTimes, TYPE_FLOAT, "", null)
			
			# Finally, we add the animation to our array!
			var characterAnimation = CharacterAnimationStorage.new(setID, setFrames, setLoopPoint, setFrameTimes)
			animations.append(characterAnimation)
		
	func get_in_between_numbers(numbers: String): ## Converts our string of a number dash to individual numbers.
		var firstAndLastNumbers = numbers.split("-", false)
		# We have to convert the strings to integers, oops...
		var firstNum = firstAndLastNumbers[0].to_int()
		var lastNum = firstAndLastNumbers[1].to_int()
		
		# Now, we need to detect if one is higher than the other and swap 'em if so.
		if firstNum > lastNum:
			var firstNumRemembrance = firstNum
			firstNum = lastNum
			lastNum = firstNumRemembrance
			
		# Finally, we gotta get everything in an array!
		var finalArray: Array
		while firstNum <= lastNum:
			finalArray.append(firstNum)
			firstNum += 1
			
		return finalArray
	
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
	
