extends CanvasLayer

# Dictionaries won't work here, as if you did:
# "Icon": $Player1/Icon.texture,
# then changing it would change the dictionary's definition, NOT the node property.
# So, we're gonna have to go back to using the old variables method...
# ...maybe there's another way to optimize this?

@onready var player_1_icon = $Player1/Icon
@onready var player_1_precioustones = $Player1/PrecioustoneCount
@onready var player_1_rings = $Player1/RingCount
@onready var player_1_placement = $Player1/Placement
@onready var player_1_top_border_gradient = $Player1/TopBorderGradient
@onready var player_1_bottom_border = $Player1/BottomBorder
@onready var player_1 = [player_1_icon, player_1_precioustones, player_1_rings, player_1_placement, player_1_top_border_gradient, player_1_bottom_border]

@onready var player_2_icon = $Player2/Icon
@onready var player_2_precioustones = $Player2/PrecioustoneCount
@onready var player_2_rings = $Player2/RingCount
@onready var player_2_placement = $Player2/Placement
@onready var player_2_top_border_gradient = $Player2/TopBorderGradient
@onready var player_2_bottom_border = $Player2/BottomBorder
@onready var player_2 = [player_2_icon, player_2_precioustones, player_2_rings, player_2_placement, player_2_top_border_gradient, player_2_bottom_border]

@onready var player_3_icon = $Player3/Icon
@onready var player_3_precioustones = $Player3/PrecioustoneCount
@onready var player_3_rings = $Player3/RingCount
@onready var player_3_placement = $Player3/Placement
@onready var player_3_top_border_gradient = $Player3/TopBorderGradient
@onready var player_3_bottom_border = $Player3/BottomBorder
@onready var player_3 = [player_3_icon, player_3_precioustones, player_3_rings, player_3_placement, player_3_top_border_gradient, player_3_bottom_border]

@onready var player_4_icon = $Player4/Icon
@onready var player_4_precioustones = $Player4/PrecioustoneCount
@onready var player_4_rings = $Player4/RingCount
@onready var player_4_placement = $Player4/Placement
@onready var player_4_top_border_gradient = $Player4/TopBorderGradient
@onready var player_4_bottom_border = $Player4/BottomBorder
@onready var player_4 = [player_4_icon, player_4_precioustones, player_4_rings, player_4_placement, player_4_top_border_gradient, player_4_bottom_border]

@onready var players = [player_1, player_2, player_3, player_4]

@onready var turn_indicator = $TurnIndicator

# TODO: fill out info according to game statistics
# work on Placement and Icon
# TODO: maybe this doesn't have to run every frame? Only when it's appropriate

func _ready():
	update_hud()

func update_hud():
	# TODO: figure out why this isn't changing the text
	# My guess is it skips over the node and changes the dictionary value itself,
	# seeing as using $Player1/RingCount.text by itself does indeed work
	var turn_index = 0
	for player in players:
		var player_index = GameStatistics.turn_order[turn_index] - 1 # The HUD goes in turn order, not player order.
		
		# Stat stuff
		player[1].text = str(GameStatistics.players_info[player_index]["Precioustones"])
		player[2].text = str(GameStatistics.players_info[player_index]["Rings"])
		
		# Image stuff
		player[3].texture.region.position.x = 96 * (GameStatistics.players_info[player_index]["Placement"] - 1)
		
		# Fade stuff and Turn Indicator stuff
		# The Turn Indicator should only hover over one player at a time to signify their turn...
		# hopefully my assumption's correct LOL
		if GameStatistics.players_info[player_index]["Playing"] == true:
			player[0].modulate = Color(1.0, 1.0, 1.0)
			player[4].modulate = Color(1.0, 1.0, 1.0)
			player[5].modulate = Color(1.0, 1.0, 1.0, 0.5)
			turn_indicator.global_position = player[0].global_position
		else:
			player[0].modulate = Color(1.0/3, 1.0/3, 1.0/3)
			player[4].modulate = Color(1.0/2, 1.0/2, 1.0/2)
			player[5].modulate = Color(1.0/3, 1.0/3, 1.0/3, 0.5)
		
		turn_index += 1
