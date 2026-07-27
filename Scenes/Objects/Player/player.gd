extends CharacterBody3D ## Playable characters for all intents and purposes.

# TODO: when the character is switched or when the player is initialized, reload all of our animations
var character: String = "sonic" ## Which character are we dealing with?
var characterID: int = 0 ## Internally, what character ID are we using?
var playerID: int = 0 ## What player is attached to this guy?
@export var mainState: String ## What state are we in?

# TODO: scale pixelsize to be accurate to box constraints

@onready var sprite = $Sprite3D
@onready var animationPlayer = $Sprite3D/AnimationPlayer

func _ready():
	refresh_animations()
	play_animation("stand")

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
	sprite.vframes = characterImage.get_height() / usedCharacter.boxHeight
	
	# TODO: add animations
	# This is the tricky part; actually adding our animations!
	
	# First things first, we've gotta reset the AnimationPlayer's current animations.
	var globalLibrary = animationPlayer.get_animation_library("")
	
	while animationPlayer.get_animation_list():
		globalLibrary.remove_animation(animationPlayer.get_animation_list()[0])
	
	var animationIndex = 0
	
	animationPlayer.set_root_node(get_path())
	
	while animationIndex <= usedCharacter.animations.size() - 1:
		# Define our data for ease of use
		var id = usedCharacter.animations[animationIndex].id
		var frames = usedCharacter.animations[animationIndex].frames 
		var frameTimes = usedCharacter.animations[animationIndex].frameTimes
		
		# Add our animation, then set its initial properties.
		var animation = Animation.new()
		
		var length = 0
		for frameTime in frameTimes:
			length += frameTime
		animation.length = length
		
		# Get our tracks
		var xFrameCoord = animation.add_track(Animation.TYPE_VALUE)
		animation.track_set_path(xFrameCoord, "Sprite3D:frame_coords:x")
		animation.track_set_interpolation_type(xFrameCoord, Animation.INTERPOLATION_NEAREST)
		
		var yFrameCoord = animation.add_track(Animation.TYPE_VALUE)
		animation.track_set_path(yFrameCoord, "Sprite3D:frame_coords:y")
		animation.track_set_interpolation_type(yFrameCoord, Animation.INTERPOLATION_NEAREST)
		
		# We just need to do the Y frame coord once...
		animation.track_insert_key(yFrameCoord, 0.0, animationIndex)
		
		# For the X, however, we've gotta do that for all of our frames!
		var frameIndex = 0
		var currentFrameTime = 0
		while frameIndex <= frames.size() - 1:
			# TODO: fix the timing of this thing!
			animation.track_insert_key(xFrameCoord, currentFrameTime, frames[frameIndex])
			print(currentFrameTime * 60)
			currentFrameTime += frameTimes[frameIndex]
			frameIndex += 1
		
		# And finally, we add our animation!!
		globalLibrary.add_animation(id, animation)
		
		animationIndex += 1
	print(animationPlayer.get_animation_list())

func play_animation(animationName: String):
	# TODO: play the animation if it exists; if it doesn't, fall back to the next on the list
	while true: # Do this until we find an animation we can play.
		for currentAnimationName in animationPlayer.get_animation_list(): # Loop through everything until we find a valid animation
			if currentAnimationName == animationName:
				animationPlayer.play(animationName)
				return
		# The following will only run if no animation of that type exists
		for currentGlobalAnimation in Global_Statistics.characterAnimations:
			if currentGlobalAnimation.id == animationName:
				animationName = currentGlobalAnimation.fallbackID

# Loop animations
func _on_animation_player_animation_finished(anim_name):
	var animationIndex = 0 # We need to find our index for our ID.
	
	var usedCharacter = Global_Statistics.characters[characterID] # Just for easier access.
	for currentAnimation in usedCharacter.animations:
		if currentAnimation.id == anim_name:
			break
		animationIndex += 1
	
	var loopPoint = usedCharacter.animations[animationIndex].loopPoint # What frame are we looking for?
	var frameTimes = usedCharacter.animations[animationIndex].frameTimes # What times are these frames?
	var startTime = 0
	var amountToLoopPoint = 0
	while amountToLoopPoint < loopPoint:
		startTime += frameTimes[amountToLoopPoint]
		amountToLoopPoint += 1
	
	# Finally, play our animation again!
	animationPlayer.play_section(anim_name, startTime)
