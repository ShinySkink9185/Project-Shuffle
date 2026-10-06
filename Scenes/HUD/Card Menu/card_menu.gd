extends CanvasLayer

# We put everything inside a Visuals control tab because of problems with
# moving everything individually. In hindsight, maybe it would've been better
# if this entire node was a Control... I think we'll be fine as-is, though.

@onready var player_1_icon = $Visuals/Player1/PlayerIcon
@onready var player_1_border = $Visuals/Player1/Border
@onready var player_1_cards = []
@onready var player_1_card_marker = $Visuals/Player1/Marker2D
@onready var player_1_node = $Visuals/Player1
@onready var player_1 = [player_1_icon, player_1_border, player_1_cards, player_1_card_marker, player_1_node]

@onready var player_2_icon = $Visuals/Player2/PlayerIcon
@onready var player_2_border = $Visuals/Player2/Border
@onready var player_2_cards = []
@onready var player_2_card_marker = $Visuals/Player2/Marker2D
@onready var player_2_node = $Visuals/Player2
@onready var player_2 = [player_2_icon, player_2_border, player_2_cards, player_2_card_marker, player_2_node]

@onready var player_3_icon = $Visuals/Player3/PlayerIcon
@onready var player_3_border = $Visuals/Player3/Border
@onready var player_3_cards = []
@onready var player_3_card_marker = $Visuals/Player3/Marker2D
@onready var player_3_node = $Visuals/Player3
@onready var player_3 = [player_3_icon, player_3_border, player_3_cards, player_3_card_marker, player_3_node]

@onready var player_4_icon = $Visuals/Player4/PlayerIcon
@onready var player_4_border = $Visuals/Player4/Border
@onready var player_4_cards = []
@onready var player_4_card_marker = $Visuals/Player4/Marker2D
@onready var player_4_node = $Visuals/Player4
@onready var player_4 = [player_4_icon, player_4_border, player_4_cards, player_4_card_marker, player_4_node]

@onready var players = [player_1, player_2, player_3, player_4]
@onready var cards = [player_1_cards, player_2_cards, player_3_cards, player_4_cards]

var menu_ready = false # Is the menu ready to display options and handle input?
var option_selected = Vector2(0, 0) # What option have we selected in this menu?
var player_selecting = 1 # Which player controller is choosing in the menu?
var delay_timer = 0 # How much delay do we have?
var direction = "" # What direction are we going in?

# TODO: We need four control handlers, one for our main and three for our players.
var control_handler = ShuffleControlHandler.new()
var card_scene = load("res://Scenes/HUD/Card Menu/card.tscn")
var player_order = Array(GameStatistics.turn_order)

var sub_control_handler_1 = ShuffleControlHandler.new()
var sub_control_handler_2 = ShuffleControlHandler.new()
var sub_control_handler_3 = ShuffleControlHandler.new()

const INITIAL_DELAY = 10.0/30.0
const HOLDING_DELAY = 7.0/30.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# First, get our current order.
	# TODO: make the card display option per-player, and
	# MAKE SURE ONLINE PLAYERS HAVE THE SETTING LINKED TO THEM TOO!
	if GlobalStatistics.settings["Card Display"] == 0:
		# Move our player to be the first one on the list.
		player_order.erase(player_selecting)
		player_order.push_front(player_selecting)
	
	# Get us our player controller
	control_handler.player_controlling = player_selecting
	
	# Get us our sub-controllers
	if control_handler.player_controlling <= 1:
		sub_control_handler_1.player_controlling = 2
	else:
		sub_control_handler_1.player_controlling = 1
	
	if control_handler.player_controlling <= 2:
		sub_control_handler_2.player_controlling = 3
	else:
		sub_control_handler_2.player_controlling = 2
	
	if control_handler.player_controlling <= 3:
		sub_control_handler_3.player_controlling = 4
	else:
		sub_control_handler_3.player_controlling = 3
	
	var order_index = 0
	for player in players:
		var player_index = player_order[order_index]
		
		# Image stuff
		player[0].playerID = player_index
	
		# Change the color of our border, depending on the character.
		# TODO: do that
		var character_ID = 0
		
		# Change our character ID string over here.
		var character = GameStatistics.players_info[player_index - 1]["Character"]
		
		# First, we need to check if our character is valid.
		var character_found = false
		
		for current_character in GlobalStatistics.characters:
			if current_character.id == character:
				character_found = true
				break
			character_ID += 1
		
		if character_found == false:
			print("ERROR: Character " + character + " not found! Reverting to Sonic.")
			character = "sonic"
			character_ID = 0
		
		# Now, load our color border
		player[1].modulate = GlobalStatistics.characters[character_ID].color
		
		order_index += 1
	
	# Load our cards
	load_cards()

# Called every frame. 'delta' is the elapsed time since the previous frame.
# TODO: Navigation through the menu.
# TODO: Support input for map viewing
# TODO: Shuffling cards. The player choosing from the menu cannot shuffle;
# all other players can. There is no special animation for it.
func _process(delta: float) -> void:
	# Holding takes 7 frames. Starting takes 10 frames.
	
	# Nullify our direction.
	if control_handler.is_action_just_released("move_right") and direction == "right" \
	or control_handler.is_action_just_released("move_left") and direction == "left" \
	or control_handler.is_action_just_released("move_up") and direction == "up" \
	or control_handler.is_action_just_released("move_down") and direction == "down":
		direction = ""
	
	# Set our direction.
	# NOTICE: Would be helpful if your selection could keep going diagonally
	if control_handler.is_action_just_pressed("move_right"):
		direction = "right"
		card_switch(direction)
		delay_timer = INITIAL_DELAY
	
	if control_handler.is_action_just_pressed("move_left"):
		direction = "left"
		card_switch(direction)
		delay_timer = INITIAL_DELAY
	
	if control_handler.is_action_just_pressed("move_up"):
		direction = "up"
		card_switch(direction)
		delay_timer = INITIAL_DELAY
	
	if control_handler.is_action_just_pressed("move_down"):
		direction = "down"
		card_switch(direction)
		delay_timer = INITIAL_DELAY
	
	# Highlight our new card.
	if delay_timer <= 0:
		if direction == "up" or direction == "down" or direction == "left" or direction == "right":
			card_switch(direction)
		if delay_timer <= 0:
			delay_timer = HOLDING_DELAY
	
	if menu_ready == true:
		# Make our card hover.
		cards[option_selected.x][option_selected.y].hovering = true
		
		# Exit out of the menu if input is pressed.
		# TODO: do that
		# TODO: also add ability to shuffle cards
		if control_handler.is_action_just_pressed("cancel"):
			pass
	
	# Move our clock down.
	delay_timer -= delta
	
	
	
# Reshuffle everyone's cards 
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Enter" and player_1_cards == [] and player_2_cards == [] and player_3_cards == [] and player_4_cards == []:
		GameStatistics.reshuffle_cards()
		load_cards(true)
	elif anim_name == "Enter":
		_on_menu_just_ready()
		
# Add all of our Cards!
func load_cards(fading := false):
	var order_index = 0
	for player in players:
		var player_index = player_order[order_index]
		
		var card_index = 0
		for current_card in GameStatistics.players_info[player_index - 1]["Cards"]:
			var card = card_scene.instantiate()
			card.type = current_card
			card.position = Vector2(player[3].position.x + (card_index * 40), player[3].position.y)
			if GlobalStatistics.settings["Card System"] == 0 and player_index == player_selecting:
				card.showing = true
			else:
				card.showing = false
			if fading == true:
				card.appearing = true
			else:
				card.appearing = false
			player[2].append(card)
			# Connect the signal before we add our child.
			if order_index == 0 and card_index == 0 and fading == true:
				player_1_cards[0].finished_appearing.connect(_on_menu_just_ready)
			player[4].add_child(card)
			card_index += 1
		
		if fading == true:
			await get_tree().create_timer(1.0/30.0).timeout
	
		order_index += 1


func _on_menu_just_ready():
	print("Menu ready!")
	# Positioning the cursor at the start.
	for player in players:
		if player[2] != []:
			break
		option_selected.y += 1
	menu_ready = true

func card_switch(direction: String):
	var coord_change
	if direction == "up":
		coord_change = Vector2(0, -1)
	elif direction == "down":
		coord_change = Vector2(0, 1)
	elif direction == "left":
		coord_change = Vector2(-1, 0)
	elif direction == "right":
		coord_change = Vector2(1, 0)
	# Switch up the coord change to prevent breaking LOL
	coord_change = Vector2(coord_change.y, coord_change.x)
	if option_selected.x + coord_change.x >= 0 and option_selected.x + coord_change.x <= 3 \
	and option_selected.y + coord_change.y >= 0 and option_selected.y + coord_change.y <= cards[coord_change.x].size() - 1:
		cards[option_selected.x][option_selected.y].hovering = false
		option_selected = Vector2(option_selected.x + coord_change.x, option_selected.y + coord_change.y)
