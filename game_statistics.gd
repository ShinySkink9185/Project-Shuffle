extends Node ## This is our storage of things that are relevant to the current game.
class_name Game_Statistics

# Each player's info.
# Oooo, first time I'm trying dictionaries!!
# Maybe I should've done that instead of classes for the global statistics...
static var player_1_info = {
	"Playing": true, 
	"Character": "sonic",
	"Precioustones": 0,
	"Rings": 0,
	"Duels": 0,
	"Forcejewels": [null, null, null, null, null],
	"Space": 0,
	"Effects": [],
	"Placement": 1
}

static var player_2_info = {
	"Playing": true, 
	"Character": "sonic",
	"Precioustones": 0,
	"Rings": 0,
	"Duels": 0,
	"Forcejewels": [null, null, null, null, null],
	"Space": 0,
	"Effects": [],
	"Placement": 1
}

static var player_3_info = {
	"Playing": true, 
	"Character": "sonic",
	"Precioustones": 0,
	"Rings": 0,
	"Duels": 0,
	"Forcejewels": [null, null, null, null, null],
	"Space": 0,
	"Effects": [],
	"Placement": 1
}

static var player_4_info = {
	"Playing": true, 
	"Character": "sonic",
	"Precioustones": 0,
	"Rings": 0,
	"Duels": 0,
	"Forcejewels": [null, null, null, null, null],
	"Space": 0,
	"Effects": [],
	"Placement": 1
}

static var players_info = [player_1_info, player_2_info, player_3_info, player_4_info]

static var forcejewels_left = 7
static var current_turn = 1
static var turn_order = [1, 2, 3, 4]

# For future reference. Whenever you add an effect to the player,
# add it to the array as a dictionary, with a "Name" and the "Duration".
# Make sure the duration counts down whenever you need it to.

# TODO: add a function that gets a player's placing. Calculate by Precioustones first, then by Rings.
# TODO: add a similar function only for the end of the game, counting Emblems instead of Precioustones.

func _process(delta):
	# TODO: this doesn't have to run every frame; only when it needs to
	# (say, when the ring/preciousstone count is updated)
	determine_placements()

func _ready(): # NOTICE: Debug, remove later
	determine_placements()
	print("Placements in player order: "[player_1_info["Placement"] + ", "])
	
func determine_placements():
	# TODO: determine placements.
	# Search for whoever has the most Precioustones.
	# If two or more have the same amount of Precioustones, check Rings.
	# If they also have the same Ring amount, both have the same placement.
	# The next placement down is always 1 lower; it never skips placements.
	var current_place = 1
	var players_can_be_grabbed = [true, true, true, true]
	while players_can_be_grabbed != [false, false, false, false]:
		# Iterate through all players that can be grabbed for Precioustones
		var max_precioustones = {
			"Count": 0, # what's the current record precioustones?
			"Held By": [false, false, false, false], # what players hold the record?
		}
		
		var player_precioustone_index = 0
		for player_info in players_info:
			if player_info["Precioustones"] > max_precioustones["Count"]:
				max_precioustones["Count"] = player_info["Precioustones"]
				max_precioustones["Held By"] = [false, false, false, false]
			if player_info["Precioustones"] >= max_precioustones["Count"]:
				max_precioustones["Held By"][player_precioustone_index] = true
			player_precioustone_index += 1
		
		# Check if two or more players have the same Precioustone count
		# If so, organize them by Rings
		# TODO: do that
		if max_precioustones["Held By"].count(true) >= 2:
			var max_rings = {
				"Count": 0, # what's the current record rings?
				"Held By": [false, false, false, false], # what players hold the record?
			}
			
			var player_ring_index = 0
			for player_info in players_info:
				if player_info["Precioustones"] > max_precioustones["Count"]:
					max_precioustones["Count"] = player_info["Precioustones"]
					max_precioustones["Held By"] = [false, false, false, false]
				if player_info["Precioustones"] >= max_precioustones["Count"]:
					max_precioustones["Held By"][player_precioustone_index] = true
				player_precioustone_index += 1
