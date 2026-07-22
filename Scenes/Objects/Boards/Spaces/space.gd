class_name BoardSpace
extends Node3D
## This is the base class for all the board spaces in the game.
## It's very generalized, and can be used in multiple cases!

var active: bool = true ## Is this space currently active?
var playerOfInterest ## The player who passed by or landed on the space.
# TODO: maybe it would be better if the two below were signals instead
var playerLanded: bool = false ## Did a player just land on the space?
var playerPassed: bool = false ## Did a player just pass the space?
var deductSpaceCount: bool = false ## If the player passed this space, does this deduct one move from their card?

const ID: int = -1 ## What ID is this space?
const AvailableIDs: Array[int] = [] ## What IDs can this space travel to?

# Constantly checks whether a player has landed or passed the space.
func _physics_process(_delta):
	if playerLanded == true:
		playerLanded = false
		on_player_landed()
	if playerPassed == true:
		playerPassed = false
		on_player_passed()

func on_player_landed(): ## Function to be run when a player has landed on the space.
	pass

func on_player_passed(): ## Function to be run when a player has passed the space.
	if deductSpaceCount == true:
		# TODO: deduct space count from the player
		pass
