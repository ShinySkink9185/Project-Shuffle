extends CanvasLayer

# We put everything inside a Visuals control tab because of problems with
# moving everything individually. In hindsight, maybe it would've been better
# if this entire node was a Control... I think we'll be fine as-is, though.

@onready var player_1_icon = $Visuals/Player1/PlayerIcon
@onready var player_1_border = $Visuals/Player1/Border
@onready var player_1 = [player_1_icon, player_1_border]

@onready var player_2_icon = $Visuals/Player2/PlayerIcon
@onready var player_2_border = $Visuals/Player2/Border
@onready var player_2 = [player_2_icon, player_2_border]

@onready var player_3_icon = $Visuals/Player3/PlayerIcon
@onready var player_3_border = $Visuals/Player3/Border
@onready var player_3 = [player_3_icon, player_3_border]

@onready var player_4_icon = $Visuals/Player4/PlayerIcon
@onready var player_4_border = $Visuals/Player4/Border
@onready var player_4 = [player_4_icon, player_4_border]

@onready var players = [player_1, player_2, player_3, player_4]

var menu_ready = false # Is the menu ready to display options and handle input?
var option_selected = Vector2(0, 0) # What option have we selected in this menu?
var player_selecting = 1 # Which player controller is choosing in the menu?

var control_handler = ShuffleControlHandler.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# First, get our current turn order.
	# TODO: formatting for all the players. Here's how it works:
	# If the global setting for Card Display is 1,
	# the players are shown, from top to bottom, in player (not turn) order.
	# If it is set to 0,
	# the player that's currently playing is moved to the top of the list,
	# and the other players are shifted accordingly.
	# TODO: make said option per-player, and
	# MAKE SURE ONLINE PLAYERS HAVE THE SETTING LINKED TO THEM TOO!
	var player_order = Array(GameStatistics.turn_order)
	print(player_order)
	if GlobalStatistics.settings["Card Display"] == 0:
		# Move our player to be the first one on the list.
		player_order.erase(player_selecting)
		player_order.push_front(player_selecting)
	
	# Replace our icon.
	# TODO: do that
	var order_index = 0
	for player in players:
		var player_index = player_order[order_index]
		
		# Image stuff
		player[0].playerID = player_index
	
		# Change the color of our border, depending on the character.
		# TODO: do that
		var characterID = 0
		
		# Change our character ID string over here.
		var character = GameStatistics.players_info[player_index - 1]["Character"]
		
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
		
		# Now, load our color border
		player[1].modulate = GlobalStatistics.characters[characterID].color
		
		order_index += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
